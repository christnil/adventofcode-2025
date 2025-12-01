defmodule Aoc.Runner do
  @moduledoc """
  Helper to run AoC solutions by day from Elixir code or an escript/mix task.
  """

  @doc """
  Run a given `day` with `type` (:input | :test).

  Example:
      Aoc.Runner.run(1, :test)
  """
  def run(day, type \\ :input) do
    mod = day_module(day)

    if Code.ensure_loaded?(mod) and function_exported?(mod, :run, 1) do
      {p1, p2} = mod.run(type)
      IO.puts("Day #{pad(day)} (#{type}):")
      IO.puts("  Part 1: #{p1}")
      IO.puts("  Part 2: #{p2}")
      {p1, p2}
    else
      raise "No module with run/1 found for #{inspect(mod)}"
    end
  end

  defp day_module(day) do
    day_str =
      day
      |> to_string()
      |> String.to_integer()
      |> then(&String.pad_leading(Integer.to_string(&1), 2, "0"))

    Module.concat([Aoc.Days, "Day#{day_str}"])
  end

  defp pad(day) do
    day
    |> to_string()
    |> String.to_integer()
    |> then(&String.pad_leading(Integer.to_string(&1), 2, "0"))
  end
end
