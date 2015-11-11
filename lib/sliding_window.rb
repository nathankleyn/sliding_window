# Implementation of the sliding window algorithm.
class SlidingWindow
  include Enumerable

  # Initialize the sliding window. Given a buffer to slide over, the maximum
  # size of the window, and a block to test whether the window matches anything,
  # enumerate the sliding window instance to get at the matches.
  #
  # buffer - The buffer to slide the window over. It can be any type, as long as
  #          it responds to `#[]` and `#size`.
  # max_size - The maximum allowed length of the window. Defaults to 5.
  # block - A block which will test whether the position of the current window
  #         matches anything of interest. The block is passed the current window
  #         into the buffer and is expected to return an object if the window
  #         matches (it can be anything), otherwise `nil`. The objects returned
  #         by this block will be yielded to the enumerable.
  def initialize(buffer, max_size = 5, &block)
    fail('The given buffer must respond to #[] and #size.') unless buffer.respond_to?(:[]) && buffer.respond_to?(:size)
    fail('The maximum buffer size must be greater than or equal to one.') if max_size.nil? || max_size < 1
    fail('A block is required to indicate whether a window matches anything of interest.') unless block_given?

    @buffer = buffer
    @max_size = max_size
    @mapper = block
  end

  # Enumerable yields each time the window matches on something. The internal
  # window is slid forward as expected.
  def each
    position = (0..@max_size - 1)

    loop do
      window = @buffer[position]
      match = @mapper.call(window)

      if match.nil?
        position = (position.begin..position.end - 1)
        position = slide_unmatched_window(position) if position.end < position.begin
      else
        yield match
        position = slide_matched_window(position)
      end

      break if position.first >= @buffer.size
    end
  end

  private

  def slide_unmatched_window(position)
    start = position.begin + 1
    (start..start + @max_size)
  end

  def slide_matched_window(position)
    (position.end + 1..position.end + @max_size)
  end
end
