defmodule Aoc.Days.Day09Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day09
  alias Aoc.Input

  @day 9

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day09.part1(data) == 27
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day09.part2(data) == 27
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day09.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day09.part2(data))
  end
end
