defmodule Aoc.Input do
  @moduledoc """
  Helpers for Advent of Code input handling.
  """

  @base "priv/inputs"

  @doc """
  Build path like "priv/inputs/day_01/input.txt" or "priv/inputs/day_01/test.txt".

  `day` can be integer or "01"/"1".
  `type` is :input or :test.
  """
  def path(day, type \\ :input) do
    day_str =
      day
      |> to_string()
      |> String.to_integer()
      |> then(&String.pad_leading(Integer.to_string(&1), 2, "0"))

    filename =
      case type do
        :input -> "input.txt"
        :test -> "test.txt"
        other -> to_string(other)
      end

    Path.join([@base, "day_#{day_str}", filename])
  end

  @doc """
  Read raw contents for given `day` and `type` (:input | :test).
  """
  def raw(day, type \\ :input) do
    day
    |> path(type)
    |> File.read!()
  end

  @doc """
  Non-empty, trimmed lines.
  """
  def lines(day, type \\ :input) do
    day
    |> raw(type)
    |> String.split("\n", trim: true)
  end

  @doc """
  Convenience: integers per line.
  """
  def integers(day, type \\ :input) do
    day
    |> lines(type)
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Line groups separated by blank lines.
  """
  def line_groups(day, type \\ :input) do
    day
    |> raw(type)
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
  end
end
