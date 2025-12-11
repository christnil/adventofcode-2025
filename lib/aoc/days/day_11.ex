defmodule Aoc.Days.Day11 do
  @moduledoc """
  Day 11 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input

  @day 11

  def get_neighbormap(lines) do
    lines
    |> Enum.reduce(%{}, fn line, acc ->
      [src, neighbours] = String.split(line, ":", trim: true)
      neigh_list = String.split(neighbours, " ", trim: true)
      Map.put(acc, src, neigh_list)
    end)
  end

  @doc """
  Find the number of unique paths from "you" to "out" using dynamic programming and memoization. and recursion.
  """
  def part1(lines) do
    neighbormap = get_neighbormap(lines)
    {count, _memo} = count_paths("you", "out", neighbormap, %{})
    count
  end

  # Count paths from a given node to "out" using memoization.
  # Returns {count, updated_memo}.
  defp count_paths(node, target, neighbormap, memo) do
    # Base case: if we reached "out", there's 1 path
    if node == target do
      {1, memo}
    else
      # Check if we've already computed this
      case Map.get(memo, node) do
        nil ->
          # Get neighbors, or empty list if node has no neighbors
          neighbors = Map.get(neighbormap, node, [])

          # Count paths through all neighbors
          {total, updated_memo} =
            Enum.reduce(neighbors, {0, memo}, fn neighbor, {acc_count, acc_memo} ->
              {neighbor_count, new_memo} = count_paths(neighbor, target, neighbormap, acc_memo)
              {acc_count + neighbor_count, new_memo}
            end)

          # Store in memo
          updated_memo = Map.put(updated_memo, node, total)
          {total, updated_memo}

        cached_count ->
          # Return cached result
          {cached_count, memo}
      end
    end
  end

  @doc """
  Part 2: Find paths through intermediate waypoints.
  For real input, counts paths: you->fft->dac->out + you->dac->fft->out
  For test input, returns a placeholder value.
  """
  def part2(lines) do
    neighbormap = get_neighbormap(lines)

    count1 =
      [
        count_paths("svr", "fft", neighbormap, %{}),
        count_paths("fft", "dac", neighbormap, %{}),
        count_paths("dac", "out", neighbormap, %{})
      ]
      |> Enum.map(fn {c, _m} -> c end)
      |> Enum.product()

    count2 =
      [
        count_paths("svr", "dac", neighbormap, %{}),
        count_paths("dac", "fft", neighbormap, %{}),
        count_paths("fft", "out", neighbormap, %{})
      ]
      |> Enum.map(fn {c, _m} -> c end)
      |> Enum.product()

    count1 + count2
  end

  @spec run(any()) :: {number(), number()}
  @doc """
  Run for :input or :test.

  Returns {part1_result, part2_result}.
  """
  def run(type \\ :input) do
    data = Input.lines(@day, type)
    {part1(data), part2(data)}
  end
end
