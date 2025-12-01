defmodule Aoc.Days.Day10Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day10
  alias Aoc.Input

  @day 10

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day10.part1(data) == 30
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day10.part2(data) == 30
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day10.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day10.part2(data))
  end
end
