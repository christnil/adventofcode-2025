defmodule Aoc.Days.Day06Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day06

  test "part1 on test input sums numbers" do
    data = Day06.get_data(:test)
    assert Day06.part1(data) == 4277556
  end

  test "part2 on test input sums numbers" do
    data = Day06.get_data(:test)
    assert is_integer(Day06.part2(data))
  end

  test "part1 on real input returns an integer" do
    data = Day06.get_data(:input)
    assert Day06.part1(data) == 8108520669952
  end

  test "part2 on real input returns an integer" do
    data = Day06.get_data(:input)
    assert is_integer(Day06.part2(data))
  end
end
