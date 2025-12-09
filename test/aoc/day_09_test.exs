defmodule Aoc.Days.Day09Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day09

  test "part1 on test input sums numbers" do
    data = Day09.get_input(:test)
    assert Day09.part1(data) == 50
  end

  test "part2 on test input sums numbers" do
    data = Day09.get_input(:test)
    assert Day09.part2(data) == 24
  end

  test "part1 on real input returns an integer" do
    data = Day09.get_input(:input)
    assert Day09.part1(data) == 4774877510
  end

  test "part2 on real input returns an integer" do
    data = Day09.get_input(:input)
    assert Day09.part2(data) ==  1560475800
  end
end
