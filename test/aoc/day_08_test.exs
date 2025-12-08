defmodule Aoc.Days.Day08Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day08

  test "part1 on test input sums numbers" do
    data = Day08.get_input(:test)
    assert Day08.part1(data, 10) == 40
  end

  test "part2 on test input sums numbers" do
    data = Day08.get_input(:test)
    assert Day08.part2(data) == 25272
  end

  test "part1 on real input returns an integer" do
    data = Day08.get_input(:input)
    assert Day08.part1(data, 1000) == 83520
  end

  test "part2 on real input returns an integer" do
    data = Day08.get_input(:input)
    assert Day08.part2(data) == 1131823407
  end
end
