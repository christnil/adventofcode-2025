defmodule Aoc.Days.Day11Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day11
  alias Aoc.Input

  @day 11

  test "part1 on test input sums numbers" do
    data = Input.lines(@day, :test)
    assert Day11.part1(data) == 5
  end

  test "part2 on test input sums numbers" do
    lines = [
      "svr: aaa bbb",
      "aaa: fft",
      "fft: ccc",
      "bbb: tty",
      "tty: ccc",
      "ccc: ddd eee",
      "ddd: hub",
      "hub: fff",
      "eee: dac",
      "dac: fff",
      "fff: ggg hhh",
      "ggg: out",
      "hhh: out"
    ]
    assert Day11.part2(lines) == 2
  end

  test "part1 on real input returns an integer" do
    data = Input.lines(@day, :input)
    assert Day11.part1(data) == 791
  end

  test "part2 on real input returns an integer" do
    data = Input.lines(@day, :input)
    assert is_integer(Day11.part2(data))
  end
end
