defmodule Aoc.Days.Day09 do
  @moduledoc """
  Day 9 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input

  @day 9

  def get_input(type \\ :input) do
    Input.lines(@day, type)
    |> Enum.map(fn line ->
      String.split(line, ",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> Enum.with_index()
    |> Enum.map(fn {{x, y}, idx} -> {x, y, idx} end)
  end

  @doc """
  Placeholder Part 1: sum all numbers.
  """
  def part1(data) do
    for {ax, ay, ai} <- data, {bx, by, bi} <- data, ai > bi do
      (abs(ax - bx) + 1) * (abs(ay - by) + 1)
    end
    |> Enum.max()
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
    data = get_input(type)
    {part1(data), part2(data)}
  end
end
