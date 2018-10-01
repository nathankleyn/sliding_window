# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = 'sliding_window'
  gem.version = '1.1.0'
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

  # Uncomment this if you plan on having an executable instead of a library.
  # gem.executables << 'your_wonderful_gem'
  gem.files = Dir['**/*'].select { |d| d =~ %r{^(README.md|bin/|ext/|lib/)} }

  # Add your dependencies here as follows:
  #
  #   gem.add_dependency 'some-gem', '~> 1.0'

  # Add your test dependencies here as follows:
  #
  #   gem.add_development_dependency 'whatever', '~> 1.0'
  #
  # Some sane defaults follow.
  gem.add_development_dependency 'coveralls', '~> 0.8.22'
  gem.add_development_dependency 'filewatcher', '~> 1.1', '>= 1.1.1'
  gem.add_development_dependency 'pry-byebug', '~> 3.6', '>= 3.6.0'
  gem.add_development_dependency 'rspec', '~> 3.8', '>= 3.8.0'
  gem.add_development_dependency 'rubocop', '~> 0.59.2'
  gem.add_development_dependency 'rubocop-rspec', '~> 1.29', '>= 1.29.1'
end
