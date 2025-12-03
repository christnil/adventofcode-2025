defmodule Aoc.Days.Day02Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day02
  alias Aoc.Input

  @day 2

  test "rounds to power of ten correctly" do
    assert Day02.round_up_to_10(5) == 10
    assert Day02.round_up_to_10(10) == 100
    assert Day02.round_up_to_10(57) == 100
    assert Day02.round_up_to_10(100) == 1000
    assert Day02.round_up_to_10(1234) == 10000
  end

  test "repeats number correctly" do
    assert Day02.repeat_number(5) == 55
    assert Day02.repeat_number(10) == 1010
    assert Day02.repeat_number(57) == 5757
    assert Day02.repeat_number(100) == 100_100
    assert Day02.repeat_number(1234) == 12_341_234
  end

  test "finds correct repeats in ranges" do
    assert Day02.get_repeating_in_range({11, 22}) == [11, 22]
    assert Day02.get_repeating_in_range({99, 115}) == [99]
    assert Day02.get_repeating_in_range({998, 1012}) == [1010]
    assert Day02.get_repeating_in_range({1_188_511_880, 1_188_511_890}) == [1_188_511_885]
    assert Day02.get_repeating_in_range({222_220, 222_224}) == [222_222]
    assert Day02.get_repeating_in_range({1_698_522, 1_698_528}) == []
    assert Day02.get_repeating_in_range({446_443, 446_449}) == [446_446]
    assert Day02.get_repeating_in_range({38_593_856, 38_593_862}) == [38_593_859]
  end

  test "detects repeating patterns correctly" do
    # Single digit repeated
    assert Day02.is_repeating_pattern?(11) == true
    assert Day02.is_repeating_pattern?(111) == true
    assert Day02.is_repeating_pattern?(1111) == true
    assert Day02.is_repeating_pattern?(22) == true
    assert Day02.is_repeating_pattern?(999) == true

    # Multi-digit patterns repeated
    assert Day02.is_repeating_pattern?(1212) == true
    assert Day02.is_repeating_pattern?(121_212) == true
    assert Day02.is_repeating_pattern?(123_123) == true
    assert Day02.is_repeating_pattern?(123_123_123) == true
    assert Day02.is_repeating_pattern?(1010) == true

    # Not repeating patterns
    assert Day02.is_repeating_pattern?(12) == false
    assert Day02.is_repeating_pattern?(123) == false
    assert Day02.is_repeating_pattern?(1234) == false
    assert Day02.is_repeating_pattern?(112) == false
    assert Day02.is_repeating_pattern?(1213) == false
  end

  test "finds all repeating patterns in ranges (Part 2)" do
    # Should find both 99 (9×2) and 111 (1×3)
    assert Day02.get_repeating_in_range_v2({95, 115}) == [99, 111]

    # Should find both 999 (9×3) and 1010 (10×2)
    assert Day02.get_repeating_in_range_v2({998, 1012}) == [999, 1010]

    # Should find 565656 (56×3)
    assert Day02.get_repeating_in_range_v2({565_653, 565_659}) == [565_656]

    # Should find 824824824 (824×3)
    assert Day02.get_repeating_in_range_v2({824_824_821, 824_824_827}) == [824_824_824]

    # Small range with multiple patterns
    assert Day02.get_repeating_in_range_v2({11, 22}) == [11, 22]
  end

  test "part1 on test input sums numbers" do
    data =
      Input.raw(@day, :test)
      |> Day02.parse_input()

    assert Day02.part1(data) == 1_227_775_554
  end

  test "part2 on test input sums numbers" do
    data =
      Input.raw(@day, :test)
      |> Day02.parse_input()

    assert Day02.part2(data) == 4_174_379_265
  end

  test "part1 on real input returns an integer" do
    data =
      Input.raw(@day, :input)
      |> Day02.parse_input()

    assert Day02.part1(data) == 23_039_913_998
  end

  test "part2 on real input returns an integer" do
    data =
      Input.raw(@day, :input)
      |> Day02.parse_input()

    assert is_integer(Day02.part2(data))
  end
end
