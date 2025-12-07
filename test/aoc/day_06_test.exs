defmodule Aoc.Days.Day06Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day06

  test "part1 on test input sums numbers" do
    data = Day06.get_data(:test)
    assert Day06.part1(data) == 4_277_556
  end

  test "part2 on test input sums numbers" do
    data = Day06.get_data(:test)
    assert Day06.part2(data) == 3_263_827
  end

  test "part1 on real input returns an integer" do
    data = Day06.get_data(:input)
    assert Day06.part1(data) == 8_108_520_669_952
  end

  test "part2 on real input returns an integer" do
    data = Day06.get_data(:input)
    assert Day06.part2(data) == 11_708_563_470_209
  end
end
