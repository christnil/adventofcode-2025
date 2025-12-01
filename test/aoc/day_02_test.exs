defmodule Aoc.Days.Day02Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day02
  alias Aoc.Input

  @day 2

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day02.part1(data) == 6
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day02.part2(data) == 6
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day02.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day02.part2(data))
  end
end
