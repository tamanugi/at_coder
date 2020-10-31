defmodule IntegerCard.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, _] = read_array()
    as = read_array() |> Enum.sort()

    bs =
      IO.binstream(:stdio, :line)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.split(&1, " "))
      |> Stream.map(fn s -> Enum.map(s, &String.to_integer/1) end)
      |> Enum.to_list()
      |> Enum.sort_by(fn [_, c] -> c end, :desc)

    solve(as, bs, [])
    |> IO.puts()
  end

  def solve(as, [], acc), do: Enum.sum(as) + Enum.sum(acc)
  def solve(as, [[b, c] | t], acc) do
    {cand, as} = Enum.split(as, b)

    cand = cand |> Enum.map(fn i -> if i < c, do: c, else: i end) |> Enum.sum()
    solve(as, t, [cand | acc])
  end

  def test() do
    n = 100000
    as = for i <- 1..n, do: i
    bs = for i <- n..1, do: [:rand.uniform * 1000 |> floor, i]

    :timer.tc(&solve/3, [as, bs, []])
    |> IO.inspect()
  end

end
