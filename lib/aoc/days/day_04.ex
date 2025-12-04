defmodule Aoc.Days.Day04 do
  @moduledoc """
  Day 4 placeholder solution. Replace with real puzzle logic.
  """

  alias Aoc.Input
  alias Aoc.Grid

  @day 4

  def get_data(type \\ :input) do
    lines = Input.lines(@day, type)
    grid = Grid.from_lines(lines)
    grid
  end

  @doc """
  Remove paper rolls (@ cells with < 4 @ neighbors) from the grid.
  Returns {new_grid, count} where count is the number of paper rolls removed.
  """
  def remove_paper(grid) do
    {maxX, maxY} = Grid.size(grid)

    {to_remove, count} =
      Enum.reduce(0..(maxY - 1), {[], 0}, fn y, {cells, count_acc} ->
        Enum.reduce(0..(maxX - 1), {cells, count_acc}, fn x, {cells_acc, count_acc2} ->
          current_cell = Grid.get(grid, {x, y}, ".")

          if current_cell == "@" do
            number_of_neighbors =
              Grid.neighbors8({x, y})
              |> Enum.filter(fn coord -> Grid.get(grid, coord, ".") == "@" end)
              |> length()

            if number_of_neighbors < 4 do
              {[{x, y} | cells_acc], count_acc2 + 1}
            else
              {cells_acc, count_acc2}
            end
          else
            {cells_acc, count_acc2}
          end
        end)
      end)

    new_grid =
      Enum.reduce(to_remove, grid, fn coord, grid_acc ->
        Grid.put(grid_acc, coord, ".")
      end)

    {new_grid, count}
  end

  @doc """
  Part 1: Remove paper rolls in one iteration and return the count.
  """
  def part1(grid) do
    {_, count} = remove_paper(grid)
    count
  end

  @doc """
  Part 2: Keep removing paper rolls until no more can be removed.
  Returns the total count of all paper rolls removed across all iterations.
  """
  def part2(grid) do
    remove_paper_until_done(grid, 0)
  end

  defp remove_paper_until_done(grid, total_count) do
    {new_grid, count} = remove_paper(grid)

    if count == 0 do
      total_count
    else
      remove_paper_until_done(new_grid, total_count + count)
    end
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
