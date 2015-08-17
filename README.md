# scold
Hound-like Rubocop utilities

The `scold` command calls Rubucop using the same configuration as Hound
merged with `.rubocop.yml` file in the current directory, if present, then
merged with `~/.rubocop_strict.yml` if present.

The `hound` command calls `scold` with uncommitted git files, if any; otherwise
does nothing.

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
