# scold
Hound-like Rubocop utilities

The `scold` command calls Rubucop using the same configuration as Hound
merged with `.rubocop.yml` file in the current directory, if present, then
merged with `~/.rubocop_strict.yml` if present.

The `hound` command calls `scold` with changed git files, if any; otherwise
does nothing.  Unlike the Hound web service, this command inspects entire
files, not just changed lines.

# Usage

Add to `Gemfile`:
```
gem "scold", require: false
```

From command line:
```
bundle exec scold [rubocop-options] [files...]
```
```
bundle exec hound [rubocop-options] 
```

# Development

```
bundle exec rspec # test locally
rm *.gem; gem build *.gemspec # build locally
gem push *.gem # publish to rubygems.org
```
