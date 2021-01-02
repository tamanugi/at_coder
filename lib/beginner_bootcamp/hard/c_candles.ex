defmodule Candles.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, k] = read_array()
    xs = read_array() |> Enum.with_index() |> Enum.map(fn {v, i} -> {i, v} end) |> Map.new()

    solve(0..(k-1), n, xs, 1000_000_000_000)
    |> IO.puts()
  end

  def solve(_left..right, n, _xs, acc) when right >= n, do: acc
  def solve(left..right, n, xs, acc) do
    l = xs[left]
    r = xs[right]

    acc =
      min(
        min(abs(l), abs(r)) + abs(r - l),
        acc
      )

    solve(left+1..right+1, n, xs, acc)
  end

end
