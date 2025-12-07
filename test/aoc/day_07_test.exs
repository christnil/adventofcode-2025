defmodule Aoc.Days.Day07Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day07
  alias Aoc.Input
  alias Aoc.Grid

  @day 7

  test "part1 on test input sums numbers" do
    data = Input.lines(@day, :test)
    |> Grid.from_lines()
    assert Day07.part1(data) == 21
  end

  test "part2 on test input sums numbers" do
    data = Input.lines(@day, :test)
    |> Grid.from_lines()
    assert Day07.part2(data) == 40
  end

  test "part1 on real input returns an integer" do
    data = Input.lines(@day, :input)
    |> Grid.from_lines()
    assert Day07.part1(data) == 1562
  end

  test "part2 on real input returns an integer" do
    data = Input.lines(@day, :input)
    |> Grid.from_lines()
    assert Day07.part2(data) == 24292631346665
  end
end
