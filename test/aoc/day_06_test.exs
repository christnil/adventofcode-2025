defmodule Aoc.Days.Day06Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day06
  alias Aoc.Input

  @day 6

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day06.part1(data) == 18
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day06.part2(data) == 18
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day06.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day06.part2(data))
  end
end
