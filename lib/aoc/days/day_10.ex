defmodule Aoc.Days.Day10 do
  @moduledoc """
  Day 10: Button Press Optimization

  Part 1: Count indicator lights that can be lit
  Part 2: Find minimum button presses to configure joltage levels using Gaussian Elimination
  """

  alias Aoc.Input

  @day 10

  @doc """
  Part 1: Parse machines and count indicator lights that can be lit.
  """
  def part1(lines) do
    lines
    |> Enum.map(&parse_machine/1)
    |> Enum.map(&count_indicator_lights/1)
    |> Enum.sum()
  end

  @doc """
  Part 2: Find minimum button presses to configure joltage levels.
  """
  def part2(lines) do
    results =
      lines
      |> Enum.map(&parse_machine/1)
      |> Enum.map(&min_button_presses/1)

    results
    |> Enum.filter(&(&1 != :infinity))
    |> Enum.sum()
  end

  defp parse_machine(line) do
    # Parse pattern [.##.], buttons (x,y,z), and target {a,b,c}
    [pattern_part | rest] = String.split(line, "] ")
    pattern = String.trim_leading(pattern_part, "[")

    # Split remaining by } to separate buttons from target
    button_and_target = Enum.join(rest, "] ")
    [button_part, target_part] = String.split(button_and_target, " {")

    # Parse buttons
    buttons =
      Regex.scan(~r/\(([0-9,]+)\)/, button_part)
      |> Enum.map(fn [_, indices] ->
        indices
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
      end)

    # Parse target
    target =
      target_part
      |> String.trim_trailing("}")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    %{pattern: pattern, buttons: buttons, target: target}
  end

  defp count_indicator_lights(%{pattern: pattern, buttons: buttons}) do
    lights = parse_pattern(pattern)
    reachable = find_reachable_lights(lights, buttons)
    MapSet.size(reachable)
  end

  defp parse_pattern(pattern) do
    pattern
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {char, _} -> char == "#" end)
    |> Enum.map(fn {_, idx} -> idx end)
    |> MapSet.new()
  end

  defp find_reachable_lights(lights, buttons) do
    initial = MapSet.new()
    queue = :queue.from_list([initial])
    visited = MapSet.new([initial])
    bfs_reachable(queue, visited, lights, buttons)
  end

  defp bfs_reachable(queue, visited, lights, buttons) do
    case :queue.out(queue) do
      {{:value, current}, rest} ->
        new_states =
          Enum.flat_map(buttons, fn button_indices ->
            new_state =
              Enum.reduce(button_indices, current, fn idx, state ->
                if MapSet.member?(state, idx) do
                  MapSet.delete(state, idx)
                else
                  MapSet.put(state, idx)
                end
              end)

            if Enum.all?(button_indices, &MapSet.member?(lights, &1)) do
              [new_state]
            else
              []
            end
          end)
          |> Enum.reject(&MapSet.member?(visited, &1))

        new_visited = Enum.reduce(new_states, visited, &MapSet.put(&2, &1))
        new_queue = Enum.reduce(new_states, rest, &:queue.in(&1, &2))
        bfs_reachable(new_queue, new_visited, lights, buttons)

      {:empty, _} ->
        visited
    end
  end

  defp min_button_presses(%{buttons: buttons, target: target}) do
    matrix = build_matrix(buttons, target)
    solve_gaussian(matrix)
  end

  defp build_matrix(buttons, target) do
    num_counters = length(target)

    Enum.map(0..(num_counters - 1), fn counter_idx ->
      row =
        Enum.map(buttons, fn button ->
          if counter_idx in button, do: 1, else: 0
        end)

      row ++ [Enum.at(target, counter_idx)]
    end)
  end

  defp solve_gaussian(matrix) do
    rows = length(matrix)
    cols = length(hd(matrix))
    reduced = gaussian_elimination(matrix, 0, 0, rows, cols)
    backpropagate(reduced)
  end

  defp gaussian_elimination(matrix, row, col, rows, cols) do
    cond do
      row >= rows or col >= cols - 1 ->
        matrix

      true ->
        case find_pivot(matrix, row, col, rows) do
          nil ->
            gaussian_elimination(matrix, row, col + 1, rows, cols)

          pivot_row ->
            matrix = if pivot_row != row, do: swap_rows(matrix, row, pivot_row), else: matrix
            matrix = normalize_row(matrix, row, col)
            matrix = eliminate_column(matrix, row, col, rows)
            gaussian_elimination(matrix, row + 1, col + 1, rows, cols)
        end
    end
  end

  defp find_pivot(matrix, start_row, col, rows) do
    Enum.find(start_row..(rows - 1), fn row ->
      val = matrix |> Enum.at(row) |> Enum.at(col)
      val != 0
    end)
  end

  defp swap_rows(matrix, row_a, row_b) do
    row_a_data = Enum.at(matrix, row_a)
    row_b_data = Enum.at(matrix, row_b)

    matrix
    |> List.replace_at(row_a, row_b_data)
    |> List.replace_at(row_b, row_a_data)
  end

  defp normalize_row(matrix, row_idx, pivot_col) do
    row = Enum.at(matrix, row_idx)
    pivot_val = Enum.at(row, pivot_col)

    if pivot_val == 0 do
      matrix
    else
      normalized_row = Enum.map(row, fn val -> val / pivot_val end)
      List.replace_at(matrix, row_idx, normalized_row)
    end
  end

  defp eliminate_column(matrix, pivot_row, col, rows) do
    if pivot_row + 1 > rows - 1 do
      matrix
    else
      Enum.reduce((pivot_row + 1)..(rows - 1), matrix, fn row_idx, acc ->
        combine_rows(acc, row_idx, pivot_row, col)
      end)
    end
  end

  defp combine_rows(matrix, target_row, source_row, col) do
    target = Enum.at(matrix, target_row)
    source = Enum.at(matrix, source_row)
    factor = Enum.at(target, col)

    if factor == 0 or is_nil(target) or is_nil(source) do
      matrix
    else
      new_row =
        Enum.zip(target, source)
        |> Enum.map(fn {t, s} -> t - factor * s end)

      List.replace_at(matrix, target_row, new_row)
    end
  end

  defp backpropagate(matrix) do
    num_vars = length(hd(matrix)) - 1
    initial_solution = List.duplicate(nil, num_vars)
    solutions = search_solutions(matrix, length(matrix) - 1, initial_solution, [])

    if solutions == [] do
      :infinity
    else
      solutions
      |> Enum.map(&sum_solution/1)
      |> Enum.min()
    end
  end

  defp search_solutions(_matrix, row, solution, solutions) when row < 0 do
    [solution | solutions]
  end

  defp search_solutions(matrix, row, solution, solutions) do
    equation = Enum.at(matrix, row)
    target = List.last(equation)
    coeffs = Enum.drop(equation, -1)

    {known_sum, unknowns} =
      Enum.zip(coeffs, solution)
      |> Enum.with_index()
      |> Enum.reduce({0, []}, fn {{coeff, val}, idx}, {sum, unks} ->
        if val != nil do
          {sum + coeff * val, unks}
        else
          if coeff != 0, do: {sum, [{idx, coeff} | unks]}, else: {sum, unks}
        end
      end)

    remaining = target - known_sum

    cond do
      unknowns == [] ->
        if abs(remaining) < 0.001 do
          search_solutions(matrix, row - 1, solution, solutions)
        else
          solutions
        end

      length(unknowns) == 1 ->
        [{idx, coeff}] = unknowns
        val = remaining / coeff

        if abs(val - round(val)) < 0.001 and round(val) >= 0 do
          new_solution = List.replace_at(solution, idx, round(val))
          search_solutions(matrix, row - 1, new_solution, solutions)
        else
          solutions
        end

      true ->
        try_combinations(matrix, row, solution, solutions, unknowns, remaining)
    end
  end

  defp try_combinations(matrix, row, solution, solutions, unknowns, remaining) do
    num_unknowns = length(unknowns)

    max_val =
      cond do
        num_unknowns <= 2 -> min(400, round(abs(remaining)) + 100)
        num_unknowns == 3 -> 200
        num_unknowns == 4 -> 120
        true -> 80
      end

    generate_combinations(unknowns, remaining, max_val, solution)
    |> Enum.reduce(solutions, fn new_solution, acc ->
      search_solutions(matrix, row - 1, new_solution, acc)
    end)
  end

  defp generate_combinations([], remaining, _max_val, solution) do
    if abs(remaining) < 0.001, do: [solution], else: []
  end

  defp generate_combinations([{idx, coeff} | rest], remaining, max_val, solution) do
    num_remaining = length(rest)
    slack = 60 + num_remaining * 35

    limit = round(ceil((abs(remaining) + slack) / max(1, abs(coeff))))
    limit = min(limit, max_val)

    Enum.flat_map(0..limit, fn val ->
      new_solution = List.replace_at(solution, idx, val)
      new_remaining = remaining - coeff * val
      generate_combinations(rest, new_remaining, max_val, new_solution)
    end)
  end

  defp sum_solution(solution) do
    solution
    |> Enum.reject(&is_nil/1)
    |> Enum.sum()
  end

  @doc """
  Run for :input or :test.

  Returns {part1_result, part2_result}.
  """
  def run(type \\ :input) do
    lines = Input.lines(@day, type)
    {part1(lines), part2(lines)}
  end
end
