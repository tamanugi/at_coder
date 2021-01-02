defmodule Trained.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    _ = read_single()

    bs =
      IO.binstream(:stdio, :line)
      |> Stream.map(&String.trim/1)
      |> Stream.with_index(1)
      |> Stream.map(fn {n, i} -> {i, String.to_integer(n)} end)
      |> Enum.to_list()
      |> Map.new()

    solve(1, bs, 0)
    |> IO.puts()
  end

  def solve(nil, _, _), do: -1
  def solve(2, _, acc), do: acc
  def solve(i, bs, acc) do
    {next, bs} = Map.get_and_update(bs, i, fn c -> {c, nil} end)

    solve(next, bs, acc + 1)
  end

  def test() do
    n = 100_000
    # bs = for i <- 1..n, into: %{}, do: {i, 1..n |> Enum.random}
    bs = 1..n |> Enum.shuffle() |> Enum.with_index(1) |> Enum.map(fn {n, i} -> {i, n} end) |> Map.new

    :timer.tc(Trained.Main, :solve, [1, bs, 0])
    |> IO.inspect()

  end

end
