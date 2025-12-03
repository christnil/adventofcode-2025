defmodule Aoc.Days.Day02 do
  @moduledoc """
  Day 2 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input

  @day 2

  @doc """
  Parse list of directions and counts from a input like L12, R5, etc.
  """
  def parse_input(raw) do
    raw
    |> String.split(",", trim: true)
    |> Enum.map(fn str ->
      String.split(str, "-", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end

  def round_down_to_10(n) when n > 0 do
    :math.pow(10, :math.log10(n) |> floor()) |> trunc()
  end

  @doc """
  Round a number up to a power of ten
  """
  def round_up_to_10(n) when n > 0 do
    round_down_to_10(n) * 10
  end

  @doc """
  Calculate a repeating number based on input
  """
  def repeat_number(n) do
    round_up_to_10(n) * n + n
  end

  @doc """
  Check if a number is in a given range
  """
  def in_range({start, stop}, n) do
    n >= start and n <= stop
  end

  @doc """
  Check if a number is made of a pattern repeated at least twice.
  E.g., 11 = "1" × 2, 111 = "1" × 3, 1212 = "12" × 2, 121212 = "12" × 3
  """
  def is_repeating_pattern?(n) when is_integer(n) do
    str = Integer.to_string(n)
    length = String.length(str)

    1..div(length, 2)
    |> Enum.any?(fn pattern_len ->
      if rem(length, pattern_len) == 0 do
        pattern = String.slice(str, 0, pattern_len)
        String.duplicate(pattern, div(length, pattern_len)) == str
      else
        false
      end
    end)
  end

  @doc """
  Count the number of repeating numbers in a range
  enum -> repeat -> filter
  """
  def get_repeating_in_range({start, stop}) when start > stop do
    []
  end

  def get_repeating_in_range({start, stop}) do
    # Get the digit lengths we need to check
    start_len = String.length(Integer.to_string(start))
    stop_len = String.length(Integer.to_string(stop))

    # We only care about even-length repeating numbers
    # Check each even length from smallest to largest
    min_len = if rem(start_len, 2) == 0, do: start_len, else: start_len + 1
    max_len = if rem(stop_len, 2) == 0, do: stop_len, else: stop_len - 1

    if min_len > max_len do
      []
    else
      min_len..max_len//2
      |> Enum.flat_map(fn total_len ->
        half_len = div(total_len, 2)
        min_base = trunc(:math.pow(10, half_len - 1))
        max_base = trunc(:math.pow(10, half_len)) - 1

        min_base..max_base
        |> Enum.map(&repeat_number/1)
        |> Enum.filter(&in_range({start, stop}, &1))
      end)
    end
  end

  @doc """
  Find all numbers in a range that have any repeating pattern (at least 2 repetitions).
  This is more general than get_repeating_in_range/1 which only finds exact 2x repetitions.

  For efficiency, we still generate candidates rather than checking every number.
  We generate:
  - Single digit repeated (11, 111, 1111, etc.)
  - 2-digit patterns repeated (1212, 121212, etc.)
  - 3-digit patterns repeated (123123, 123123123, etc.)
  - And so on...
  """
  def get_repeating_in_range_v2({start, stop}) when start > stop do
    []
  end

  def get_repeating_in_range_v2({start, stop}) do
    start_len = String.length(Integer.to_string(start))
    stop_len = String.length(Integer.to_string(stop))

    # We need to check all possible total lengths
    min_len = start_len
    max_len = stop_len

    # For each total length, try all pattern lengths that divide it
    min_len..max_len
    |> Enum.flat_map(fn total_len ->
      # Try all pattern lengths from 1 to total_len/2
      # Must be at least 1, and guard against total_len < 2
      if total_len >= 2 do
        1..div(total_len, 2)
        |> Enum.filter(fn pattern_len -> rem(total_len, pattern_len) == 0 end)
        |> Enum.flat_map(fn pattern_len ->
          # Generate all patterns of this length
          min_pattern = trunc(:math.pow(10, pattern_len - 1))
          max_pattern = trunc(:math.pow(10, pattern_len)) - 1

          repetitions = div(total_len, pattern_len)

          min_pattern..max_pattern
          |> Enum.map(fn pattern ->
            # Create number by repeating the pattern
            pattern_str = Integer.to_string(pattern)
            String.duplicate(pattern_str, repetitions) |> String.to_integer()
          end)
          |> Enum.filter(&in_range({start, stop}, &1))
        end)
      else
        []
      end
    end)
    |> Enum.uniq()
    |> Enum.sort()
  end

  @doc """
  Placeholder Part 1: sum all numbers.
  """
  def part1(data) do
    Enum.flat_map(data, &get_repeating_in_range/1)
    |> Enum.sum()
  end

  @doc """
  Part 2: Find numbers with any repeating pattern (at least 2 repetitions).
  """
  def part2(data) do
    Enum.flat_map(data, &get_repeating_in_range_v2/1)
    |> Enum.sum()
  end

  @doc """
  Run for :input or :test.

  Returns {part1_result, part2_result}.
  """
  def run(type \\ :input) do
    data =
      Input.raw(@day, type)
      |> parse_input()

    {part1(data), part2(data)}
  end
end
