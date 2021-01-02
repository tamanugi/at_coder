defmodule SFF.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    solve(n)
    |> IO.inspect()
  end

  def solve(n) when n < 357, do: 0
  def solve(n) do
    digits = Integer.digits(n) |> Enum.count()

    3..digits
    |> Enum.flat_map(&sft/1)
    |> Enum.filter(fn d -> Enum.member?(d, 3) and Enum.member?(d, 5) and Enum.member?(d, 7) end)
    |> Enum.map(fn d -> Integer.undigits(d) end)
    |> Enum.filter(fn d -> d <= n end)
    |> Enum.count()
  end

  def sft(0), do: [[]]
  def sft(n) do
    sft(n - 1)
    |> Enum.flat_map(fn s -> [[3 | s], [5 | s], [7 | s]] end)
  end

  def permutation(_, 0), do: [[]]
  def permutation(list, n) do
    for x <- list, rest <- permutation(list -- [x], n - 1), do: [x | rest]
  end
end
