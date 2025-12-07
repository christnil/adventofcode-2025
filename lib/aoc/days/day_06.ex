defmodule Aoc.Days.Day06 do
  @moduledoc """
  Day 6 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input

  @day 6

  def get_data(type \\ :input) do
    raw_lines = Input.lines(@day, type)

    parsed_data =
      raw_lines
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&Enum.reverse/1)
      |> Enum.map(fn [h | t] ->
        {
          h,
          Enum.map(t, &String.to_integer/1)
        }
      end)

    {parsed_data, raw_lines}
  end

  @doc """
  Placeholder Part 1: sum all numbers.
  """
  def part1({parsed_data, _raw_lines}) do
    parsed_data
    |> Enum.map(fn {op, list} ->
      if op == "+" do
        Enum.sum(list)
      else
        Enum.product(list)
      end
    end)
    |> Enum.sum()
  end

  @doc """
  Part 2: Read cephalopod math right-to-left.

  Each number is written vertically (MSD at top, LSD at bottom).
  We read columns from right to left to extract numbers.
  """
  def part2({_parsed_data, raw_lines}) do
    parse_rtl(raw_lines)
  end

  defp parse_rtl(lines) do
    # Separate operator line from number lines
    number_lines = Enum.take(lines, length(lines) - 1)
    operator_line = List.last(lines)

    # Find max line length
    max_len = Enum.max_by(lines, &String.length/1) |> String.length()

    # Pad all lines to max length
    padded_number_lines =
      Enum.map(number_lines, fn line ->
        line <> String.duplicate(" ", max_len - String.length(line))
      end)

    padded_operator_line =
      operator_line <> String.duplicate(" ", max_len - String.length(operator_line))

    # Find operator positions
    operator_positions =
      padded_operator_line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {char, _idx} -> char in ["*", "+"] end)
      |> Enum.map(fn {_char, idx} -> idx end)

    # For each operator, find its problem
    problems =
      Enum.map(operator_positions, fn op_pos ->
        operator = String.at(padded_operator_line, op_pos)

        # Find the range of columns for this problem
        # Problems are separated by operators, so we look right from this operator
        # until we hit the next operator or end of line
        next_op_pos = Enum.find(operator_positions, max_len, fn pos -> pos > op_pos end)
        col_range = op_pos..(next_op_pos - 1)

        # Extract numbers by reading columns RTL within this range
        numbers =
          Enum.reverse(col_range)
          |> Enum.map(fn col_idx ->
            # Read this column top-to-bottom to form a number
            padded_number_lines
            |> Enum.map(&String.at(&1, col_idx))
            |> Enum.join()
            |> String.trim()
          end)
          |> Enum.reject(&(&1 == ""))
          |> Enum.map(&String.to_integer/1)

        {operator, numbers}
      end)

    # Calculate result
    problems
    |> Enum.map(fn {op, numbers} ->
      if op == "+", do: Enum.sum(numbers), else: Enum.product(numbers)
    end)
    |> Enum.sum()
  end

  @doc """
  Run for :input or :test.

  Returns {part1_result, part2_result}.
  """
  def run(type \\ :input) do
    data = get_data(type)
    {part1(data), part2(data)}
  end
end
