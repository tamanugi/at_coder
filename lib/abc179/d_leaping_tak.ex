defmodule LeapingTak.Main do
  def main() do
    [n, _] = read_array()
    lrs = read_multi_array()

    lrs
    |> solve(n, 1, %{0 => 1, 1 => 1}, %{0 => 1, 1 => 1})
    |> IO.puts()
  end

  def solve(lrs, n, i, dp, sdp) when i <= n do
    # dp =
    #   lrs
    #   |> Enum.reduce(dp, fn [l, r], dp ->
    #     ll = max(0, i - r)
    #     rr = max(0, i - l + 1)

    #     s =  Map.get(sdp, rr, 0) - Map.get(sdp, ll, 0)
    #     Map.update(dp, i, s, fn c -> rem(c + s, 998244353) end)
    #   end)

    dp = lrs |> lrs_loop(dp, sdp, i)
    sdp = Map.put(sdp, i + 1, sdp[i] + dp[i])

    solve(lrs, n, i + 1, dp, sdp)
  end
  def solve(_, _, i, dp, _), do: Map.get(dp, i - 1, 0)

  def lrs_loop([], dp, _, _), do: dp
  def lrs_loop([[l, r] | t], dp, sdp, i) do

    ll = max(0, i - r)
    rr = max(0, i - l + 1)

    s = Map.get(sdp, rr, 0) - Map.get(sdp, ll, 0)
    dp = Map.update(dp, i, s, fn c -> rem(c + s, 998244353) end)
    lrs_loop(t, dp, sdp, i)
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
