defmodule Aoc.Days.Day03 do
  @moduledoc """
  Day 3 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input

  @day 3

  @doc """
  split string into list of numbers
  """
  def tokenize_line(line) do
    line
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Find max
  """
  def find_max(list, max1 \\ 0, max2 \\ 0) do
    case list do
      [] -> (max1 * 10) + max2
      [h | t] when max2 > max1 -> find_max(t, max2, h)
      [h | t] when h > max2 -> find_max(t, max1, max(max2, h))
      [_ | t] -> find_max(t, max1, max2)
    end
  end

  @doc """
  Placeholder Part 1: sum all numbers.
  """
  def part1(data) do
    data
    |> Enum.map(&tokenize_line/1)
    |> Enum.map(&find_max/1)
    |> Enum.sum()
  end

  @doc """
  Placeholder Part 2: currently same as Part 1.
  """
  def part2(_data) do
    0
  end

  @doc """
  Run for :input or :test.

  Returns {part1_result, part2_result}.
  """
  def run(type \\ :input) do
    data = Input.lines(@day, type)
    {part1(data), part2(data)}
  end
end
