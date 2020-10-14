defmodule LeapingTak.Main do
  def main() do
    [n, _] = read_array()
    lrs = read_multi_array()

    # lrs_to_s(lrs, [])
    lrs
    |> IO.inspect()
    |> solve(n)
    |> IO.puts()
  end

  def solve(s, n, i \\ 0, dp \\ %{0 => 1, 1 => -1})

  def solve(_, n, i, dp) when i == n - 1, do: rem(Map.get(dp, i, 0), 998244353)
  def solve(lrs, n, i, dp) do
    #
    dp = if i > 0, do: Map.update!(dp, i, fn c -> c + dp[i - 1] end), else: dp
    cur = dp[i] || 0

    dp =
      lrs
      |> Enum.reduce(dp, fn [l, r], acc ->
        IO.inspect({i + l, i + r})

        acc = if i + l < n, do: Map.update(acc, i + l, cur, fn c -> c + cur end), else: dp
        acc = if i + r < n, do: Map.update(acc, i + r, cur, fn c -> c - cur end), else: dp
        acc
      end)
    # |> IO.inspect()

    solve(lrs, n, i + 1, dp)
  end

  def lrs_to_s([], s), do: s |> Enum.uniq() |> Enum.sort()
  def lrs_to_s([[l, r]| t], s) do
    s = Enum.concat(l..r |> Enum.map(fn i -> i end), s)
    lrs_to_s(t, s)
  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_map() do
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> read_map(0, %{})
  end

  def read_map([], _, acc), do: acc
  def read_map([h|t], i, acc) do
    acc = Map.put(acc, i, String.to_integer(h))
    read_map(t, i + 1, acc)
  end

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def test() do
    n = 100000
    steps = (for _ <- 1..n, do: (1..300 |> Enum.random()) * 10 |> Integer.to_string) |> read_map(0, %{})
    {time, _} = :timer.tc(Main, :solve, [n, 100, steps])
    IO.inspect(time)
  end


end
