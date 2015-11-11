# Sliding Window [![Build Status](https://travis-ci.org/nathankleyn/sliding_windowsvg)](https://travis-ci.org/nathankleyn/sliding_window) [![RubyGems Version Of gitignore_rb](https://img.shields.io/gem/v/sliding_window.svg)](https://rubygems.org/gems/sliding_window)

Implements the sliding window algorithm. This is useful for traversing phrases during NEL processing.

## Usage

The Gem is called `sliding_window` and you can it is available via [RubyGems](https://rubygems.org/gems/sliding_window):

```sh
gem install sliding_window
```

## Examples

A simple example is as follows:

```ruby
require 'sliding_window'

mapping = {
  'The Queen' => 'Queen Elizabeth II',
  'Queen' => 'Queen (band)',
  'Buckingham Palace' => 'Buckingham Palace'
}

sliding_window = SlidingWindow.new(%w{The Queen attended a concert at Buckingham Palace where Queen played some music}) do |window|
  key = window.join(' ')
  mapping[key] if mapping.include?(key)
end

sliding_window.to_a # => ['Queen Elizabeth II', 'Buckingham Palace', 'Queen (band)']
```
