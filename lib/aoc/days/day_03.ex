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
  find the maximum n-digit number that can be formed from the list by skipping digits
  """
  def find_max(list, n) when is_integer(n) and n > 0 do
    initial_maxes = Enum.take(list, n)
    rest = Enum.drop(list, n)

    find_max(rest, initial_maxes)
  end

  def find_max([], current) when is_list(current) do
    Enum.reduce(current, 0, fn cur, acc -> acc * 10 + cur end)
  end

  def find_max([h | t], current) when is_list(current) do
    new_current = update_maxes(current, h)
    find_max(t, new_current)
  end

  # Append new val to list and remove 1 item from the list
  # Option 1 the first item in the list less than its follower
  # Option 2 if no such item, remove the last item
  defp update_maxes(maxes, new_val) do
    list = maxes ++ [new_val]

    list
    |> Enum.with_index()
    |> Enum.reduce_while(nil, fn
      {cur, idx}, _acc when idx < length(list) - 1 ->
        next = Enum.at(list, idx + 1)

        if cur < next do
          {:halt, idx}
        else
          {:cont, nil}
        end

      {_cur, idx}, _acc when idx == length(list) - 1 ->
        {:halt, idx}

      _, acc ->
        {:cont, acc}
    end)
    |> case do
      nil -> Enum.drop(list, 1)
      idx -> List.delete_at(list, idx)
    end
  end

  @doc """
  Placeholder Part 1: sum all numbers.
  """
  def part1(data) do
    data
    |> Enum.map(&tokenize_line/1)
    |> Enum.map(&find_max(&1, 2))
    |> Enum.sum()
  end

  @doc """
  Placeholder Part 2: currently same as Part 1.
  """
  def part2(data) do
    data
    |> Enum.map(&tokenize_line/1)
    |> Enum.map(&find_max(&1, 12))
    |> Enum.sum()
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
