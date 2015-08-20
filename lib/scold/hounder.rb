module Scold
  class Hounder
    CHANGED = %w(M A R C).freeze

    def initialize(args = [])
      @args = args.dup
    end

    def call # rubocop:disable Metrics/AbcSize
      files = `git status --porcelain`.lines.inject([]) do |accum, line|
        if CHANGED.include?(line[0]) || CHANGED.include?(line[1])
          accum << line[3..-2].split("->").last.strip
        end
        accum
      end
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
