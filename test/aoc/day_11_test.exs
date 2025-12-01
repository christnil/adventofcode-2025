defmodule Aoc.Days.Day11Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day11
  alias Aoc.Input

  @day 11

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day11.part1(data) == 33
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day11.part2(data) == 33
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day11.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day11.part2(data))
  end
end
