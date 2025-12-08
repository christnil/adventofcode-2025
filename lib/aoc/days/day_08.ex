defmodule Aoc.Days.Day08 do
  @moduledoc """
  Day 8 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input

  @day 8

  def get_input(type \\ :input) do
    Input.lines(@day, type)
    |> Enum.map(fn line ->
      String.split(line, ",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end

  defp get_distance({x1, y1, z1}, {x2, y2, z2}) do
    :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2) + :math.pow(z1 - z2, 2))
  end

  @doc """
  Placeholder Part 1: sum all numbers.
  """
  def part1(data, count \\ 10) do
    group_idx = data
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {tuple, idx}, acc ->
      Map.put(acc, tuple, idx)
    end)
    point_distances_list = for a <- data, b <- data, group_idx[a] < group_idx[b], do: {{a, b}, get_distance(a, b)}
    # sort by shortest distance
    sorted_distances = point_distances_list
    |> Enum.sort_by(fn {_tuple_pair, distance} -> distance end)

    res_groups = Enum.take(sorted_distances, count)
    |> Enum.reduce(group_idx, fn {{a, b}, _distance}, acc ->
      group_a = Map.get(acc, a)
      group_b = Map.get(acc, b)
      min_group = min(group_a, group_b)
      acc
      |> Enum.map(fn {k, v} ->
        if v == group_a or v == group_b do
          {k, min_group}
        else
          {k, v}
        end
      end)
      |> Enum.into(%{})
    end)

    # reduce to {num_members, group_id}
    final_groups = res_groups
    |> Enum.reduce(%{}, fn {_k, v}, acc ->
      Map.update(acc, v, 1, &(&1 + 1))
    end)

    # get 3 largest group sizes and sum them
    final_groups
    |> Enum.map(fn {_group_id, size} -> size end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  @doc """
  Placeholder Part 2: currently same as Part 1.
  """
  def part2(data) do
    group_idx = data
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {tuple, idx}, acc ->
      Map.put(acc, tuple, idx)
    end)
    point_distances_list = for a <- data, b <- data, group_idx[a] < group_idx[b], do: {{a, b}, get_distance(a, b)}
    # sort by shortest distance
    sorted_distances = point_distances_list
    |> Enum.sort_by(fn {_tuple_pair, distance} -> distance end)

    initial_num_groups = map_size(group_idx)
    final_con_x_length = Enum.reduce_while(sorted_distances, {group_idx, initial_num_groups}, fn {{a, b}, _}, {group_idx, num_groups} ->
      group_a = Map.get(group_idx, a)
      group_b = Map.get(group_idx, b)
      if group_a != group_b do
        min_group = min(group_a, group_b)
        new_group_idx = group_idx
        |> Enum.map(fn {k, v} ->
          if v == group_a or v == group_b do
            {k, min_group}
          else
            {k, v}
          end
        end)
        |> Enum.into(%{})
        new_num_groups = num_groups - 1
        if new_num_groups <= 1 do
          {x1, _, _} = a
          {x2, _, _} = b
          {:halt, x1 * x2}
        else
          {:cont, {new_group_idx, new_num_groups}}
        end
      else
        {:cont, {group_idx, num_groups}}
      end
    end)
    final_con_x_length
  end

  @spec run(any()) :: {number(), number()}
  @doc """
  Run for :input or :test.

  Returns {part1_result, part2_result}.
  """
  def run(type \\ :input) do
    data = get_input(type)
    count = if type == :test, do: 10, else: 1000
    {part1(data, count), part2(data)}
  end
end
