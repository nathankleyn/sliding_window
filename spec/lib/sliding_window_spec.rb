# frozen_string_literal: true

require 'spec_helper'
require 'sliding_window'

RSpec.describe(SlidingWindow) do
  describe('.new') do
    let(:buffer_without_accessor) do
      instance_double(Class.new)
    end

    let(:buffer_without_size) do
      instance_double(Class.new)
    end

    it('fails if the buffer is nil') do
      expect do
        described_class.new(nil)
      end.to raise_error('The given buffer must respond to #[] and #size.')
    end

    it('fails if the buffer does not respond to #[]') do
      expect do
        described_class.new(buffer_without_accessor)
      end.to raise_error('The given buffer must respond to #[] and #size.')
    end

    it('fails if the buffer does not respond to #size') do
      expect do
        described_class.new(buffer_without_size)
      end.to raise_error('The given buffer must respond to #[] and #size.')
    end

    it('fails if the max buffer size is nil') do
      expect do
        described_class.new([], nil)
      end.to raise_error('The maximum buffer size must be greater than or equal to one.')
    end

    it('fails if the max buffer size is less than one') do
      expect do
        described_class.new([], 0)
      end.to raise_error('The maximum buffer size must be greater than or equal to one.')
    end

    it('fails if no block is given') do
      expect do
        described_class.new([])
      end.to raise_error('A block is required to indicate whether a window matches anything of interest.')
    end
  end

  describe('#each') do
    it('calls the block the correct number of times') do
      called = 0
      described_class.new((1..5).to_a, 1) { |_| called += 1 }.to_a

      expect(called).to be(5)
    end

    it('yields nothing if the block matches nothing') do
      sliding_window = described_class.new((1..5).to_a, 3) { nil }

      expect(sliding_window.to_a).to be_empty
    end

    it('skips forward for the next window when the previous window matched') do
      sliding_window = described_class.new((1..5).to_a, 3, &:itself)

      expect(sliding_window.to_a).to match_array(
        [
          [1, 2, 3],
          [4, 5]
        ]
      )
    end

    it('defaults the window size to 5') do
      sliding_window = described_class.new((1..10).to_a, &:itself)

      expect(sliding_window.to_a).to match_array(
        [
          [1, 2, 3, 4, 5],
          [6, 7, 8, 9, 10]
        ]
      )
    end

    it('yields the expected value in a real-world example') do
      buffer = [1, 2, 3, 7, 3, 2, 3, 7, 2, 3, 4, 8, 9, 7, 8]
      mapping = {
        23 => 'N',
        234 => ' ',
        89 => 'H',
        78 => 'Q',
        37 => 'A'
      }

      max_window_size = mapping.keys.map(&:to_s).map(&:length).max
      sliding_window = described_class.new(buffer, max_window_size) do |window|
        # Convert an array of digits into a single number.
        key = window.inject { |a, e| a * 10 + e }

        if mapping.include?(key)
          mapping[key]
        elsif key.to_s.length == 1
          window.first.to_s
        end
      end

      expect(sliding_window.to_a.join).to eql('1N73N7 HQ')
    end

    it('yields the expected value in an real-world example with possible ambiguities') do
      buffer = %w[The Queen attended a concert at Buckingham Palace where Queen played some music]
      mapping = {
        'The Queen' => 'Queen Elizabeth II',
        'Queen' => 'Queen (band)',
        'Buckingham Palace' => 'Buckingham Palace'
      }

      sliding_window = described_class.new(buffer) do |window|
        key = window.join(' ')
        mapping[key] if mapping.include?(key)
      end

      expect(sliding_window.to_a).to match_array(['Queen Elizabeth II', 'Buckingham Palace', 'Queen (band)'])
    end
  end
end
