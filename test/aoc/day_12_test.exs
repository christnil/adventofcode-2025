defmodule Aoc.Days.Day12Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day12
  alias Aoc.Input

  @day 12

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day12.part1(data) == 36
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day12.part2(data) == 36
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day12.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day12.part2(data))
  end
end
