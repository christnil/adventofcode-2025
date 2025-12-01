defmodule Aoc.Days.Day05Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day05
  alias Aoc.Input

  @day 5

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day05.part1(data) == 15
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day05.part2(data) == 15
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day05.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day05.part2(data))
  end
end
