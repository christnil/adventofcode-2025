defmodule Aoc.Grid do
  @type coord :: {integer(), integer()}
  @type t(v) :: %{coord() => v}

  @doc """
  Build grid from lines. `value_fun` converts each character (string len 1) to a value.
  """
  def from_lines(lines, value_fun \\ & &1) do
    Enum.with_index(lines)
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {ch, x}, acc2 ->
        Map.put(acc2, {x, y}, value_fun.(ch))
      end)
    end)
  end

  def size(grid) do
    coords = Map.keys(grid)

    {max_x, _} = Enum.max_by(coords, fn {x, _} -> x end)
    {_, max_y} = Enum.max_by(coords, fn {_, y} -> y end)

    {max_x + 1, max_y + 1}
  end

  def in_bounds?(grid, {x, y}) do
    {w, h} = size(grid)
    x >= 0 and x < w and y >= 0 and y < h
  end

  def get(grid, coord, default \\ nil), do: Map.get(grid, coord, default)
  def put(grid, coord, value), do: Map.put(grid, coord, value)

  def neighbors4({x, y}) do
    [
      {x, y - 1},
      {x + 1, y},
      {x, y + 1},
      {x - 1, y}
    ]
  end

  def neighbors8({x, y}) do
    for dy <- -1..1, dx <- -1..1, not (dx == 0 and dy == 0), do: {x + dx, y + dy}
  end

  def manhattan({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)

  def move({x, y}, :up), do: {x, y - 1}
  def move({x, y}, :down), do: {x, y + 1}
  def move({x, y}, :left), do: {x - 1, y}
  def move({x, y}, :right), do: {x + 1, y}
  def move({x, y}, {dx, dy}), do: {x + dx, y + dy}

  def find_positions(grid, value) do
    grid
    |> Enum.filter(fn {_coord, v} -> v == value end)
    |> Enum.map(fn {coord, _v} -> coord end)
  end

  def print(grid, value_to_string \\ &to_string/1, io_device \\ :stdio) do
    {w, h} = size(grid)

    for y <- 0..(h - 1) do
      row =
        for x <- 0..(w - 1) do
          grid
          |> Map.get({x, y}, " ")
          |> value_to_string.()
        end
        |> Enum.join("")

      IO.puts(io_device, row)
    end

    :ok
  end
end
