module Scold
  class Scolder
    def initialize(args)
      @args = args.dup
    end

    def call
      err = 1
      cfg_hound = File.expand_path("../hound.yml", __FILE__)
      cfg_current = File.expand_path(".rubocop.yml", Dir.pwd)
      cfg_strict = File.expand_path(".rubocop_strict.yml", Dir.home)
      require "tempfile"
      cfg = Tempfile.new("rubocop-scold-")
      begin
        cfg << "inherit_from: #{cfg_hound}\n"
        cfg << "inherit_from: #{cfg_current}\n" if File.file?(cfg_current)
        cfg << "inherit_from: #{cfg_strict}\n" if File.file?(cfg_strict)
        cfg.close
        args = %W(-c #{cfg.path}).concat(@args)
        require "rubocop"
        err = RuboCop::CLI.new.run(args)
      ensure
        cfg.close!
      end
      err
    end

    def self.run(args)
      new(args).call
    end
  end
end
