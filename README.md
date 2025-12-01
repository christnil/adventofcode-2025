# Advent of Code 2025 (Elixir)

Small utility kit plus day modules for solving Advent of Code 2025 in Elixir.

## Inputs
- Files live under `priv/inputs/day_XX/`.
- Naming: `input.txt` for real input, `test.txt` for example input.
- `Aoc.Input` helpers:  
  - `raw(day, type)` -> raw string  
  - `lines/2`, `integers/2`, `line_groups/2` -> common parsers  
  - `path/2` builds the file path if you need it.

## Running a day
- CLI: `mix aoc <day>` (defaults to real input) or `mix aoc <day> test`.
- From code: `Aoc.Runner.run(day, :input | :test)` returns `{part1, part2}`.
- Each day module exposes `run/1`, `part1/1`, `part2/1`. Replace placeholder logic for days 2–12 with your solutions.

## Utilities
- `Aoc.Graph`: BFS, DFS, and A* helpers (see `lib/aoc/graph.ex` for signatures).
- `Aoc.Input`: input reading/parsing helpers (see above).

## Tests
- Run all tests: `mix test` (requires allowing Mix to start its pubsub listener).
- Day-specific tests live under `test/aoc/day_XX_test.exs`; update expectations as you solve each day.
