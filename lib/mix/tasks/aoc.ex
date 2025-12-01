defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @shortdoc "Run Advent of Code solution for a given day and input type"

  @moduledoc """
  Run a day's solution.

      mix aoc 1
      mix aoc 1 test
      mix aoc 5 input

  Defaults to :input if type not given.
  """

  @impl Mix.Task
  def run(args) do
    Mix.Task.run("app.start")

    case args do
      [day_str] ->
        day = String.to_integer(day_str)
        Aoc.Runner.run(day, :input)

      [day_str, type_str] ->
        day = String.to_integer(day_str)
        type = String.to_atom(type_str)
        Aoc.Runner.run(day, type)

      _ ->
        Mix.raise("Usage: mix aoc <day> [input|test]")
    end
  end
end
