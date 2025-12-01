defmodule Aoc.Days.Day06 do
  @moduledoc """
  Day 6 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input

  @day 6

  @doc """
  Placeholder Part 1: sum all numbers.
  """
  def part1(data) do
    Enum.sum(data)
  end

  @doc """
  Placeholder Part 2: currently same as Part 1.
  """
  def part2(data) do
    Enum.sum(data)
  end

  @doc """
  Run for :input or :test.

  Returns {part1_result, part2_result}.
  """
  def run(type \\ :input) do
    data = Input.integers(@day, type)
    {part1(data), part2(data)}
  end
end
