module Scold
  class Hounder
    def initialize(args = [])
      @args = args.dup
    end

    def call
      files = `git diff-index --name-only master`.split($RS)
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
