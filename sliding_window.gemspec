# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = 'sliding_window'
  gem.version = '1.1.1'
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

  gem.add_development_dependency 'coveralls', '~> 0.8.23'
  gem.add_development_dependency 'filewatcher', '~> 1.1', '>= 1.1.1'
  gem.add_development_dependency 'pry-byebug', '~> 3.9', '>= 3.9.0'
  gem.add_development_dependency 'rspec', '~> 3.10', '>= 3.10.0'
  gem.add_development_dependency 'rubocop', '~> 1.4', '>= 1.4.2'
  gem.add_development_dependency 'rubocop-rspec', '~> 2.0', '>= 2.0.0'
end
