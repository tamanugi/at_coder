defmodule CamelBridge.Main do
  def main() do
    [n, m] = read_array()
    ws = read_array()
    lvs =
      IO.read(:all)
      |> String.split("\n")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
      |> Enum.sort_by(fn [_, v] -> v end)
      |> read_map(0, %{})

    # {:ok, ans} = start_link(1000_000_000)

    IO.inspect({n, m})
    IO.inspect(ws)
    IO.inspect(lvs)

    # LVSのlを調整する
    lvs = 1..(m-1)
    |> Enum.reduce(lvs, fn i, acc ->
      with [l1, _] <- acc[i - 1]
      do
        Map.update!(acc, i, fn [l, v] -> [max(l, l1), v] end)
      end
    end)
    IO.inspect(lvs)

    permutation(ws, n)
    |> solve(lvs, n, m, 1000_000_000)
    |> IO.inspect()
  end

  def solve([], _, _, _, ans), do: ans
  def solve([ws | tail], lvs, n, m, ans) do
    # ws_map = ws |> read_map(0, %{})
    ds =  process(0, %{}, ws, lvs, n, m)
    dsv = Map.get(ds, n - 1)
    ans = min(dsv, ans)

    solve(tail, lvs, n, m, ans)
  end

  def process(i, ds, ws, lvs, n, m) when i <= n-2 do
    w = Enum.at(ws, i)
    ds = process2(w, ds, i, i + 1, ws, lvs, n, m)
    process(i + 1, ds, ws, lvs, n, m)
  end
  def process(_, ds, _, _, _, _), do: ds

  def process2(w, ds, i, j, ws, lvs, n, m) when j <= n - 1 do
    w = w + Enum.at(ws, j)

    # TODO: 二分探索
    k = lvs |> Map.values |>  Enum.find_index(fn [_, v] -> v >= w end) || m
    IO.inspect(if k > 0, do: lvs[k - 1] |> List.first(), else: 0)
    # k = m

    dsj = Map.get(ds, j, 0)
    dsi = Map.get(ds, i, 0) + if k > 0, do: lvs[k - 1] |> List.first(), else: 0

    ds = Map.put(ds, j, max(dsi, dsj))
    process2(w, ds, i, j + 1, ws, lvs, n, m)
  end
  def process2(_, ds, _, _, _, _, _, _), do: ds

  def binary_search_vw(lvs, w, len) do
    div(len, 2)

  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def read_map() do
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> read_map(0, %{})
  end

  def read_map([], _, acc), do: acc
  def read_map([h|t], i, acc) do
    acc = Map.put(acc, i, h)
    read_map(t, i + 1, acc)
  end

  def test() do
    n = 100000
    steps = (for _ <- 1..n, do: (1..300 |> Enum.random()) * 10 |> Integer.to_string) |> read_map(0, %{})
    {time, _} = :timer.tc(Main, :solve, [n, 100, steps])
    IO.inspect(time)
  end

  def permutation(_, 0), do: [[]]

  def permutation(list, n) do
    for x <- list, rest <- permutation(list -- [x], n - 1), do: [x | rest]
  end

end
