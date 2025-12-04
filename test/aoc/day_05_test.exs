defmodule Aoc.Days.Day05Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day05

  test "part1 on test input sums numbers" do
    data = Day05.get_data(:test)
    assert Day05.part1(data) == 3
  end

  test "part2 on test input sums numbers" do
    data = Day05.get_data(:test)
    assert Day05.part2(data) == 14
  end

  test "part1 on real input returns an integer" do
    data = Day05.get_data(:input)
    assert Day05.part1(data) == 798
  end

  test "part2 on real input returns an integer" do
    data = Day05.get_data(:input)
    assert Day05.part2(data) == 366181852921027
  end
end
