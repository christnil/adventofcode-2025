defmodule Aoc.Days.Day05 do
  @moduledoc """
  Day 5 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input

  @day 5

  def get_data(type \\ :input) do
    [range_strings, ingredient_id_strings] = Input.line_groups(@day, type)
    ranges =
      range_strings
      |> Enum.map(fn line ->
        [start_str, end_str] = String.split(line, "-")
        {String.to_integer(start_str), String.to_integer(end_str)}
      end)
    ingredient_ids =
      ingredient_id_strings
      |> Enum.map(&String.to_integer/1)
    { ranges, ingredient_ids}
  end

  def merge_ranges(ranges) do
    ranges
    |> Enum.sort_by(fn {start_range, _end_range} -> start_range end)
    |> Enum.reduce([], fn {start_range, end_range}, acc ->
      case acc do
        [] ->
          [{start_range, end_range}]
        [{last_start, last_end} | rest] ->
          if start_range <= last_end + 1 do
            new_end = max(last_end, end_range)
            [{last_start, new_end} | rest]
          else
            [{start_range, end_range} | acc]
          end
      end
    end)
    |> Enum.reverse()
  end

  @doc """
  Placeholder Part 1: sum all numbers.
  """
  def part1({ranges, ingredient_ids}) do
    merged_ranges = merge_ranges(ranges)
    ingredient_ids
    |> Enum.filter(fn id ->
      Enum.any?(merged_ranges, fn {start_range, end_range} ->
        id >= start_range and id <= end_range
      end)
    end)
    |> Enum.count()
  end

  @doc """
  Placeholder Part 2: currently same as Part 1.
  """
  def part2({ranges, _ingredient_ids}) do
    merged_ranges = merge_ranges(ranges)
    Enum.reduce(merged_ranges, 0, fn {start_range, end_range}, acc ->
      acc + (end_range - start_range + 1)
    end)
  end

  @doc """
  Run for :input or :test.

  Returns {part1_result, part2_result}.
  """
  def run(type \\ :input) do
    data = get_data(type)
    {part1(data), part2(data)}
  end
end
