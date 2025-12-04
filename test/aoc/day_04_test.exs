defmodule Aoc.Days.Day04Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day04

  test "part1 on test input sums numbers" do
    data = Day04.get_data(:test)
    assert Day04.part1(data) == 13
  end

  test "part2 on test input sums numbers" do
    data = Day04.get_data(:test)
    assert Day04.part2(data) == 43
  end

  test "part1 on real input returns an integer" do
    data = Day04.get_data(:input)
    assert Day04.part1(data) == 1549
  end

  test "part2 on real input returns an integer" do
    data = Day04.get_data(:input)
    assert Day04.part2(data) == 8887
  end
end
