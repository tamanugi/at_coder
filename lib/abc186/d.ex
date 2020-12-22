defmodule Abc186.D.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()
    as = read_array() |> Enum.sort(:desc)
    sum = as |> Enum.sum()

    solve(as, n - 1, sum, 0)
    |> IO.puts()
  end

  def solve([_], _, _, acc), do: acc
  def solve([h | t], i, sum, acc) do
    sum = sum - h
    acc = acc + ((h * i) - sum)

    solve(t, i - 1, sum, acc)
  end
end
