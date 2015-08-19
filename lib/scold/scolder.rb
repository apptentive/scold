require "scold/exit"

module Scold
  class Scolder
    DEFAULT_CFG_NAME = ".rubocop.yml"

    def initialize(args = [])
      @args = args.dup
    end

    def call # rubocop:disable Metrics/AbcSize
      err = Exit::FAILURE
      cfg_hound = File.expand_path("../hound.yml", __FILE__)
      cfg_current = File.expand_path(DEFAULT_CFG_NAME, Dir.pwd)
      cfg_strict =
        unless ENV["SCOLD_NO_STRICT"]
          File.expand_path(".rubocop_strict.yml", Dir.home)
        end

      require "tempfile"
      cfg = Tempfile.new("rubocop-scold-")
      begin
        cfg << "inherit_from:\n"
        cfg << "  - #{cfg_hound}\n"
        cfg << "  - #{cfg_current}\n" if file?(cfg_current)
        cfg << "  - #{cfg_strict}\n" if file?(cfg_strict)
        cfg.close
        args = %W(-c #{cfg.path}).concat(@args)
        require "rubocop"
        err = RuboCop::CLI.new.run(args)
      ensure
        cfg.close!
      end
      err
    end

    def self.run(args = [])
      new(args).call
    end

    private

    def file?(value)
      value && File.file?(value)
    end
  end
end
