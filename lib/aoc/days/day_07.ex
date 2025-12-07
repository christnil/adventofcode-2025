defmodule Aoc.Days.Day07 do
  @moduledoc """
  Day 7 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input
  alias Aoc.Grid

  @day 7

  @doc """
  Placeholder Part 1: sum all numbers.
  """
  def part1(grid) do
    [{start_x, start_y}] = Grid.find_positions(grid, "S")
    {_max_x, max_y} = Grid.size(grid)
    {_cur, splits} =
      Enum.reduce((start_y+1)..(max_y - 1), {[start_x], 0}, fn y, {cur, splits} ->
      new_splits = splits + Enum.count(cur, fn x -> Grid.get(grid, {x, y}) == "^" end)
      new_cur = cur
        |> Enum.flat_map(fn x ->
        if Grid.get(grid, {x, y}) == "^" do
          [x - 1, x + 1]
        else
          [x]
        end
        end)
        |> Enum.uniq()
      {new_cur, new_splits}
      end)
    splits
  end

  @doc """
  Placeholder Part 2: currently same as Part 1.
  """
  def part2(grid) do
    [{start_x, start_y}] = Grid.find_positions(grid, "S")
    {_max_x, max_y} = Grid.size(grid)
    Enum.reduce((start_y+1)..(max_y - 1), [{start_x, 1}], fn y, cur ->
      cur
        |> Enum.flat_map(fn {x, count} ->
        if Grid.get(grid, {x, y}) == "^" do
          [{x - 1, count}, {x + 1, count}]
        else
          [{x, count}]
        end
        end)
        # Sum on same index
        |> Enum.reduce(%{}, fn {idx, c}, acc ->
          new_count = Map.get(acc, idx, 0) + c
          Map.put(acc, idx, new_count)
        end)
        |> Enum.map(fn {idx, count} -> {idx, count} end)
      end)
    |> Enum.map(fn {_idx, count} -> count end)
    |> Enum.sum()
  end

  @doc """
  Run for :input or :test.

  Returns {part1_result, part2_result}.
  """
  def run(type \\ :input) do
    data = Input.lines(@day, type)
    |> Grid.from_lines()
    {part1(data), part2(data)}
  end
end
