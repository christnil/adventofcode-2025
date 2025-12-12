defmodule Aoc.Days.Day10Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day10
  alias Aoc.Input

  @day 10

  test "part1 on test input" do
    data = Input.lines(@day, :test)
    # TODO: Update expected value when we know the correct part 1 answer
    assert Day10.part1(data) == 5
  end

  test "part2 on test input" do
    data = Input.lines(@day, :test)
    assert Day10.part2(data) == 33
  end

  test "part1 on real input returns an integer" do
    data = Input.lines(@day, :input)
    assert Day10.part1(data) == 455
  end

  # Too slow to always run
  #test "part2 on real input returns an integer" do
  #  data = Input.lines(@day, :input)
  #  assert Day10.part2(data) == 17848
  #end
end
