defmodule Aoc.Days.Day03Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day03
  alias Aoc.Input

  @day 3

  test "tokenizes line into list of numbers" do
    line = "12345"
    assert Day03.tokenize_line(line) == [1, 2, 3, 4, 5]

    line = "9081726354"
    assert Day03.tokenize_line(line) == [9, 0, 8, 1, 7, 2, 6, 3, 5, 4]
  end

  test "finds max two numbers correctly" do
    assert Day03.find_max([1, 2, 3, 4, 5], 2) == 45
    assert Day03.find_max([5, 4, 3, 2, 1], 2) == 54
    assert Day03.find_max([3, 1, 4, 1, 5, 9, 2, 6, 5], 2) == 96
    assert Day03.find_max([9, 8, 7, 6, 5], 2) == 98
    assert Day03.find_max([], 2) == 0
  end

  test "part1 on test input sums numbers" do
    data = Input.lines(@day, :test)
    assert Day03.part1(data) == 357
  end

  test "part2 on test input sums numbers" do
    data = Input.lines(@day, :test)
    assert Day03.part2(data) == 3121910778619
  end

  test "part1 on real input returns an integer" do
    data = Input.lines(@day, :input)
    assert Day03.part1(data) == 17324
  end

  test "part2 on real input returns an integer" do
    data = Input.lines(@day, :input)
    assert Day03.part2(data) == 171846613143331
  end
end
