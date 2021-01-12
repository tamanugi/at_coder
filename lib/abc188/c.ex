defmodule Abc188.C.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _n = read_single()
    read_array()
    |> Enum.with_index(1)
    |> solve([])
    |> Tuple.to_list()
    |> List.last()
    |> IO.puts()
  end

  def solve([v1, v2], []), do: Enum.min_by([v1, v2], fn {v, _} -> v end)
  def solve([], [v1, v2]), do: Enum.min_by([v1, v2], fn {v, _} -> v end)
  def solve([], acc), do: solve(acc, [])
  def solve([v1, v2 | t], acc), do: solve(t, [Enum.max_by([v1, v2], fn {v, _} -> v end) | acc])
end
