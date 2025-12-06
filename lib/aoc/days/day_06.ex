defmodule Aoc.Days.Day06 do
  @moduledoc """
  Day 6 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input

  @day 6

  def get_data(type \\ :input) do
    Input.lines(@day, type)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(fn [h | t] ->
      {
        h,
        Enum.map(t, &String.to_integer/1)
      }
    end)
  end

  @doc """
  Placeholder Part 1: sum all numbers.
  """
  def part1(data) do
    data
    |> Enum.map(fn {op, list} ->
      if op == "+" do
        Enum.sum(list)
      else
        Enum.product(list)
      end
    end)
    |> Enum.sum()
  end

  @doc """
  Placeholder Part 2: currently same as Part 1.
  """
  def part2(data) do
    0
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
