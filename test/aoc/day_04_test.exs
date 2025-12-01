defmodule Aoc.Days.Day04Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day04
  alias Aoc.Input

  @day 4

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day04.part1(data) == 12
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day04.part2(data) == 12
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day04.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day04.part2(data))
  end
end
