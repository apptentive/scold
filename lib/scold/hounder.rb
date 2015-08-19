module Scold
  class Hounder
    CHANGED = %i(
      index_modified
      index_new
      worktree_modified
      worktree_new
    ).freeze

    def initialize(args = [])
      @args = args.dup
    end

    def call
      files = []
      require "rugged"
      repo = Rugged::Repository.new(Dir.pwd)
      repo.status { |f, d| files << f unless (CHANGED & d).empty? }
      if files.empty?
        require "scold/exit"
        Exit::SUCCESS
      else
        Scolder.run(@args.concat(files))
      end
    end

    def self.run(args = [])
      new(args).call
    end
  end
end
