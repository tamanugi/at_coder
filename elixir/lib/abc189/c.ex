defmodule Abc189.C.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    as = read_array()

    solve(as, 0)
    |> IO.puts()
  end

  def solve([], acc), do: acc
  def solve([ h | t ], acc) do
    tmp = process([h | t])
    solve(t, max(tmp, acc))
  end

  def process(arr) do
    m = Enum.min(arr)
    Enum.count(arr) * m
  end
end
