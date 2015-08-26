$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "scold/version"

Gem::Specification.new do |s|
  s.name = "scold"
  s.version = Scold::VERSION
  s.platform = Gem::Platform::RUBY
  s.license  = "MIT"
  s.required_ruby_version = ">= 2.1.0"
  s.authors = ["John Fearnside"]
  s.summary = "Hound-like Rubocop utility"
  s.description = "#{s.summary}."
  s.email = "john@apptentive.com"
  s.homepage = "https://github.com/apptentive/scold"
  s.files = `git ls-files`.split($RS) do |file|
    file =~ %r{^(?:
    spec/.*
    |Gemfile
    |\.rspec
    |\.gitignore
    )$}x
  end
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = %w(lib)
  s.extra_rdoc_files = %w(README.md)
  s.rubygems_version = "2.4.8"
  s.add_runtime_dependency("rubocop", "~> 0.33")
  s.add_development_dependency("bundler", "~> 1.10")
  s.add_development_dependency("rspec", "~> 3.3")
end
