module Scold
  class Hounder
    def initialize(args = [])
      @args = args.dup
    end

    def call
      require "rugged"
      repo = Rugged::Repository.new(Dir.pwd)
      # files = repo.head.target.tree.diff_workdir.deltas.map { |d| d.new_file[:path] }
      # files = repo.last_commit.diff_workdir.deltas.map { |d| d.new_file[:path] }
      files = []
      repo.status do |f, d|
        if %i(worktree_modified worktree_new index_modified index_new).include?(d)
          files << f
        end
      end
      files0 = `git diff --name-only master`.split($RS) # TODO: use rugged gem
      puts "files0=#{files0}\nfiles=#{files}"
      Scolder.run(@args.concat(files)) unless files.empty?
    end

    def self.run(args = [])
      new(args).call
    end
  end
end
