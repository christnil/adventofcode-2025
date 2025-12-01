defmodule Aoc.Days.Day03Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day03
  alias Aoc.Input

  @day 3

  test "part1 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day03.part1(data) == 9
  end

  test "part2 on test input sums numbers" do
    data = Input.integers(@day, :test)
    assert Day03.part2(data) == 9
  end

  test "part1 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day03.part1(data))
  end

  test "part2 on real input returns an integer" do
    data = Input.integers(@day, :input)
    assert is_integer(Day03.part2(data))
  end
end
