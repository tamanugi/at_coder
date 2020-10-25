defmodule CanYouSolveThis.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def main() do
    [_, _, c] = read_array()
    bs = read_array()
    inputs = read_multi_array()

    solve(inputs, bs, c, 0)
    |> IO.puts()
  end

  def solve([], _, _, acc), do: acc
  def solve([as | t], bs, c, acc) do
    r = Enum.zip(as, bs)
    |> Enum.map(fn {i, j} -> i * j end)
    |> Enum.sum()
    r = r + c

    acc = if r > 0, do: acc + 1, else: acc
    solve(t, bs, c, acc)
  end

end
