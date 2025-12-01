defmodule Aoc.Days.Day07Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day07
  alias Aoc.Input

  @day 7

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day07.part1(data) == 21
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day07.part2(data) == 21
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day07.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day07.part2(data))
  end
end
