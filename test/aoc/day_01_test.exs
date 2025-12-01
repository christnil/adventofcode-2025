defmodule Aoc.Days.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day01
  alias Aoc.Input

  @day 1

  test "parse_input produces correct structure for test input" do
    raw = Input.raw(@day, :test)
    data = Day01.parse_input(raw)

    # adapt to actual problem; just an example assertion
    assert is_list(data)
  end

  test "part1 on test input matches example" do
    raw = Input.raw(@day, :test)
    data = Day01.parse_input(raw)

    # Replace 42 with the example answer from AoC
    assert Day01.part1(data) == 3
  end

  test "part2 on test input matches example" do
    raw = Input.raw(@day, :test)
    data = Day01.parse_input(raw)

    # Replace 99 with the example answer
    assert Day01.part2(data) == 6
  end

  test "part1 on real input gives known answer" do
    raw = Input.raw(@day, :input)
    data = Day01.parse_input(raw)
    assert Day01.part1(data) == 984
  end

  test "part2 on real input gives known answer" do
    raw = Input.raw(@day, :input)
    data = Day01.parse_input(raw)
    assert Day01.part2(data) == 5657
  end
end
