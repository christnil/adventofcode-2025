defmodule Aoc.Days.Day09 do
  @moduledoc """
  Day 9: Rectangle finder in a colored tile polygon.
  """

  alias Aoc.Input

  @day 9

  def get_input(type \\ :input) do
    raw_data =
      Input.lines(@day, type)
      |> Enum.map(fn line ->
        String.split(line, ",", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
      |> Enum.with_index()
      |> Enum.map(fn {{x, y}, idx} -> {x, y, idx} end)

    # Compress coordinates to make the problem tractable
    compressed = compress_coordinates(raw_data)
    {raw_data, compressed}
  end

  defp compress_coordinates(data) do
    xs = data |> Enum.map(fn {x, _, _} -> x end) |> Enum.sort() |> Enum.uniq()
    ys = data |> Enum.map(fn {_, y, _} -> y end) |> Enum.sort() |> Enum.uniq()

    x_to_compressed = xs |> Enum.with_index() |> Map.new()
    y_to_compressed = ys |> Enum.with_index() |> Map.new()

    compressed_data =
      Enum.map(data, fn {x, y, idx} ->
        {x_to_compressed[x], y_to_compressed[y], idx}
      end)

    compressed_data
  end

  def part1({raw_data, _compressed}) do
    for {ax, ay, ai} <- raw_data, {bx, by, bi} <- raw_data, ai > bi do
      (abs(ax - bx) + 1) * (abs(ay - by) + 1)
    end
    |> Enum.max()
  end

  def part2({raw_data, compressed_data}) do
    valid_tiles_compressed = build_valid_tiles_compressed(compressed_data)

    for {ax, ay, ai} <- compressed_data, {bx, by, bi} <- compressed_data, ai > bi do
      if rectangle_uses_valid_tiles_only?(ax, ay, bx, by, valid_tiles_compressed) do
        {orig_ax, orig_ay, _} = Enum.find(raw_data, fn {_, _, idx} -> idx == ai end)
        {orig_bx, orig_by, _} = Enum.find(raw_data, fn {_, _, idx} -> idx == bi end)
        (abs(orig_ax - orig_bx) + 1) * (abs(orig_ay - orig_by) + 1)
      else
        0
      end
    end
    |> Enum.max()
  end

  defp build_valid_tiles_compressed(compressed_data) do
    border_tiles = build_border_tiles(compressed_data)
    polygon = compressed_data |> Enum.map(fn {x, y, _idx} -> {x, y} end) |> List.to_tuple()
    {min_x, max_x, min_y, max_y} = get_bounding_box(compressed_data)

    for x <- min_x..max_x,
        y <- min_y..max_y,
        MapSet.member?(border_tiles, {x, y}) or point_in_polygon?({x, y}, polygon),
        into: border_tiles,
        do: {x, y}
  end

  defp get_bounding_box(data) do
    xs = Enum.map(data, fn {x, _, _} -> x end)
    ys = Enum.map(data, fn {_, y, _} -> y end)
    {Enum.min(xs), Enum.max(xs), Enum.min(ys), Enum.max(ys)}
  end

  defp rectangle_uses_valid_tiles_only?(x1, y1, x2, y2, valid_tiles) do
    min_x = min(x1, x2)
    max_x = max(x1, x2)
    min_y = min(y1, y2)
    max_y = max(y1, y2)

    corners_valid =
      MapSet.member?(valid_tiles, {min_x, min_y}) and
        MapSet.member?(valid_tiles, {min_x, max_y}) and
        MapSet.member?(valid_tiles, {max_x, min_y}) and
        MapSet.member?(valid_tiles, {max_x, max_y})

    if not corners_valid do
      false
    else
      Enum.all?(min_x..max_x, fn x ->
        Enum.all?(min_y..max_y, fn y ->
          MapSet.member?(valid_tiles, {x, y})
        end)
      end)
    end
  end

  defp build_border_tiles(data) do
    tiles_list = Enum.map(data, fn {x, y, _idx} -> {x, y} end)
    count = length(tiles_list)

    Enum.reduce(0..(count - 1), MapSet.new(), fn i, acc ->
      {x1, y1} = Enum.at(tiles_list, i)
      {x2, y2} = Enum.at(tiles_list, rem(i + 1, count))
      line_tiles = get_line_tiles(x1, y1, x2, y2)
      MapSet.union(acc, line_tiles)
    end)
  end

  defp get_line_tiles(x1, y1, x2, y2) do
    cond do
      x1 == x2 ->
        for y <- min(y1, y2)..max(y1, y2), into: MapSet.new(), do: {x1, y}

      y1 == y2 ->
        for x <- min(x1, x2)..max(x1, x2), into: MapSet.new(), do: {x, y1}

      true ->
        MapSet.new([{x1, y1}, {x2, y2}])
    end
  end

  defp point_in_polygon?({px, py}, polygon) do
    count = tuple_size(polygon)

    crossings =
      Enum.reduce(0..(count - 1), 0, fn i, acc ->
        {x1, y1} = elem(polygon, i)
        {x2, y2} = elem(polygon, rem(i + 1, count))

        if ray_intersects_segment?(px, py, x1, y1, x2, y2) do
          acc + 1
        else
          acc
        end
      end)

    rem(crossings, 2) == 1
  end

  defp ray_intersects_segment?(px, py, x1, y1, x2, y2) do
    cond do
      min(y1, y2) > py ->
        false

      max(y1, y2) < py ->
        false

      max(x1, x2) < px ->
        false

      min(x1, x2) >= px ->
        (y1 <= py and y2 > py) or (y2 <= py and y1 > py)

      true ->
        if y1 == y2 do
          false
        else
          x_intersect = x1 + (py - y1) * (x2 - x1) / (y2 - y1)
          x_intersect > px and ((y1 <= py and y2 > py) or (y2 <= py and y1 > py))
        end
    end
  end

  def run(type \\ :input) do
    data = get_input(type)
    {part1(data), part2(data)}
  end
end
