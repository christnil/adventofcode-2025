defmodule Aoc.Days.Day01 do
  @moduledoc """
  Day 1 solution.

  Convention:
    parse_input/1 -> domain structure
    part1/1, part2/1 -> results
  """

  alias Aoc.Input

  @day 1

  @doc """
  Parse list of directions and counts from a input like L12, R5, etc.
  """
  def parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn <<dir::binary-size(1), count::binary>> ->
      {
        if(dir == "L", do: :left, else: :right),
        String.to_integer(count)
      }
      end)
  end

  @doc """
  Solve part 1 given parsed input.
  """
  def part1(data) do
    data
    |> Enum.reduce({0, 50}, fn {dir, count}, {acc, pos} ->
      next_pos = move(pos, dir, count)
      next_count = if next_pos == 0, do: acc + 1, else: acc
      {next_count, next_pos}
    end)
    |> elem(0)
  end

  @doc """
  Solve part 2 given parsed input.
  """
  def part2(data) do
    data
    |> Enum.reduce({0, 50}, fn {dir, count}, {acc, pos} ->
      zero_hits = hits_zero(dir, count, pos)

      next_pos = move(pos, dir, count)

      {acc + zero_hits, next_pos}
    end)
    |> elem(0)
  end

  defp move(pos, dir, count) do
    pos
    |> Kernel.+(delta(dir, count))
    |> Integer.mod(100)
  end

  defp delta(:left, count), do: -count
  defp delta(:right, count), do: count

  defp hits_zero(dir, count, pos) do
    k0 =
      case dir do
        :right -> Integer.mod(100 - pos, 100)
        :left -> Integer.mod(pos, 100)
      end

    first_hit = if k0 == 0, do: 100, else: k0

    if count < first_hit do
      0
    else
      div(count - first_hit, 100) + 1
    end
  end

  @doc """
  Run for :input or :test.

  Returns {part1_result, part2_result}.
  """
  def run(type \\ :input) do
    raw = Input.raw(@day, type)
    data = parse_input(raw)
    {part1(data), part2(data)}
  end
end
