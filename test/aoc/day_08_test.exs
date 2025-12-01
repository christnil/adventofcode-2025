defmodule Aoc.Days.Day08Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day08
  alias Aoc.Input

  @day 8

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day08.part1(data) == 24
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day08.part2(data) == 24
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day08.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day08.part2(data))
  end
end
