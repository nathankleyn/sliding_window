# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = 'sliding_window'
  # If current commit is tagged, that will be our version.
  # Otherwise we'll get some suffixed version, eg. 1.1.2-1-g0fc2ecd
  # Which represents a "distance" we are away from the last tag.
  #
  # Notice we tag as 'v1.2.3' but the gemspec expects just '1.2.3' so
  # we have to strip the prefix.
  gem.version = `git describe --tags`.chomp.delete_prefix('v')
  gem.homepage = 'https://github.com/username/sliding_window'
  gem.license = 'MIT'

  gem.author = 'Nathan Kleyn'
  gem.email = 'nathan@nathankleyn.com'
  gem.summary = 'Ruby implementation of a sliding window algorithm.'
  gem.description = <<~DESC
    Ruby implementation of a sliding window algorithm, which is useful for NLP
    applications where scanning text in fixed-sized windows which shrink
    smaller when no matches are made is useful.
  DESC

  gem.files = Dir['**/*'].select { |d| d =~ %r{^(README.md|bin/|ext/|lib/)} }

  gem.required_ruby_version = '>= 2.7.2'

  gem.add_development_dependency 'filewatcher', '~> 1.1', '>= 1.1.1'
  gem.add_development_dependency 'pry-byebug', '~> 3.9', '>= 3.9.0'
  gem.add_development_dependency 'rspec', '~> 3.10', '>= 3.10.0'
  gem.add_development_dependency 'rubocop', '~> 1.4', '>= 1.4.2'
  gem.add_development_dependency 'rubocop-rspec', '~> 2.0', '>= 2.0.0'
  gem.add_development_dependency 'simplecov', '~> 0.20', '>= 0.20.0'
  gem.add_development_dependency 'simplecov-lcov', '~> 0.8', '>= 0.8.0'
end
