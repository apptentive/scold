module Scold
  class Hounder
    def initialize(args = [])
      @args = args.dup
    end

    def call
      files = `git diff --name-only`.split($RS)
      Scolder.run(@args.concat(files)) unless files.empty?
    end

    def self.run(args = [])
      new(args).call
    end
  end
end
