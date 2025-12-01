defmodule Aoc.Graph do
  @moduledoc """
  Generic BFS, DFS and A* helpers.

  You pass:
    * `neighbors_fun(node) :: [neighbor]`
    * goal predicate, cost and heuristic for A*.
  """

  @type node_t :: any()

  # ---------- BFS ----------

  @doc """
  BFS from `start` until `goal?(node)` is true.
  Returns `{:ok, path}` or `:error` if no path.

  The path is [start, ..., goal].
  """
  def bfs(start, goal?, neighbors_fun) when is_function(goal?, 1) do
    do_bfs(:queue.from_list([start]), MapSet.new([start]), %{start => nil}, goal?, neighbors_fun)
  end

  defp do_bfs(queue, visited, parent, goal?, neighbors_fun) do
    case :queue.out(queue) do
      {:empty, _} ->
        :error

      {{:value, current}, queue_rest} ->
        cond do
          goal?.(current) ->
            {:ok, reconstruct_path(current, parent)}

          true ->
            {queue2, visited2, parent2} =
              neighbors_fun.(current)
              |> Enum.reduce({queue_rest, visited, parent}, fn neigh, {q, v, p} ->
                if neigh in v do
                  {q, v, p}
                else
                  {
                    :queue.in(neigh, q),
                    MapSet.put(v, neigh),
                    Map.put(p, neigh, current)
                  }
                end
              end)

            do_bfs(queue2, visited2, parent2, goal?, neighbors_fun)
        end
    end
  end

  # ---------- DFS (iterative, stack-based) ----------

  @doc """
  DFS from `start` until `goal?(node)` is true.
  Returns `{:ok, path}` or `:error`.
  """
  def dfs(start, goal?, neighbors_fun) when is_function(goal?, 1) do
    do_dfs([start], MapSet.new([start]), %{start => nil}, goal?, neighbors_fun)
  end

  defp do_dfs([], _visited, _parent, _goal?, _neighbors_fun), do: :error

  defp do_dfs([current | rest_stack], visited, parent, goal?, neighbors_fun) do
    cond do
      goal?.(current) ->
        {:ok, reconstruct_path(current, parent)}

      true ->
        {stack2, visited2, parent2} =
          neighbors_fun.(current)
          |> Enum.reduce({rest_stack, visited, parent}, fn neigh, {s, v, p} ->
            if neigh in v do
              {s, v, p}
            else
              {
                [neigh | s],
                MapSet.put(v, neigh),
                Map.put(p, neigh, current)
              }
            end
          end)

        do_dfs(stack2, visited2, parent2, goal?, neighbors_fun)
    end
  end

  # ---------- A* ----------

  @doc """
  A* search.

  Arguments:
    * start
    * goal? :: (node -> boolean)
    * neighbors_fun :: (node -> [neighbor])
    * cost_fun :: (node, neighbor -> number)
    * heuristic_fun :: (node -> number)  # admissible heuristic

  Returns `{:ok, path, cost}` or `:error`.
  """
  def astar(start, goal?, neighbors_fun, cost_fun, heuristic_fun) do
    start_h = heuristic_fun.(start)

    open_set =
      :gb_sets.singleton({start_h, 0, start}) # {f_score, tie_breaker, node}

    g_score = %{start => 0}
    parent = %{start => nil}

    do_astar(open_set, 1, g_score, parent, goal?, neighbors_fun, cost_fun, heuristic_fun)
  end

  defp do_astar(open_set, counter, g_score, parent, goal?, neighbors_fun, cost_fun, heuristic_fun) do
    if :gb_sets.is_empty(open_set) do
      :error
    else
    {{_f, _tie, current}, open_rest} = :gb_sets.take_smallest(open_set)

    cond do
      goal?.(current) ->
        path = reconstruct_path(current, parent)
        cost = Map.fetch!(g_score, current)
        {:ok, path, cost}

      true ->
        {open_next, counter_next, g_score_next, parent_next} =
          neighbors_fun.(current)
          |> Enum.reduce({open_rest, counter, g_score, parent}, fn neigh,
                                                                    {os, c, g, p} ->
            tentative_g = Map.fetch!(g, current) + cost_fun.(current, neigh)

            if tentative_g < Map.get(g, neigh, :infinity) do
              h = heuristic_fun.(neigh)
              f_score = tentative_g + h
              os2 = :gb_sets.add({f_score, c, neigh}, os)

              {
                os2,
                c + 1,
                Map.put(g, neigh, tentative_g),
                Map.put(p, neigh, current)
              }
            else
              {os, c, g, p}
            end
          end)

        do_astar(open_next, counter_next, g_score_next, parent_next, goal?, neighbors_fun, cost_fun, heuristic_fun)
    end
  end
  end

  # ---------- common ----------

  defp reconstruct_path(node, parent) do
    Stream.unfold(node, fn
      nil -> nil
      n -> {n, parent[n]}
    end)
    |> Enum.reverse()
  end
end
