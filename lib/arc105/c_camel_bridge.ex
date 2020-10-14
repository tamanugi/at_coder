defmodule CamelBridge.Main do
  def main() do
    [n, m] = read_array()
    [ws_h | ws_t] = read_array() |> Enum.sort(:desc)
    lvs =
      IO.read(:all)
      |> String.split("\n")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
      |> Enum.sort_by(fn [_, v] -> v end)
      |> read_map(0, %{})

    # IO.inspect({n, m})
    # IO.inspect([ws_h | ws_t])
    # IO.inspect(lvs)

    with [_, v] <- lvs[0],
      true <- v >= ws_h
    do
      # LVSのlを調整する
      lvs =
        if m > 1 do
          1..(m-1)
          |> Enum.reduce(lvs, fn i, acc ->
            with [l1, _] <- acc[i - 1]
            do
              Map.update!(acc, i, fn [l, v] -> [max(l, l1), v] end)
            end
          end)
        else
          lvs
        end

      # 大きさが最大のラクダは端固定できる
      permutation(ws_t, n - 1)
      |> Enum.map(fn ws -> [ws_h | ws] end)
      |> Enum.map(fn ws -> Enum.reverse(ws) end)
      |> solve(lvs, n, m, 1000_000_000)
      |> IO.puts()
    else
      _ -> IO.puts(-1)
    end
  end

  def solve([], _, _, _, ans), do: ans
  def solve([ws | tail], lvs, n, m, ans) do
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

    # 二分探索
    k = binary_search_vw(lvs, w) || m

    dsj = Map.get(ds, j, 0)
    dsi = Map.get(ds, i, 0) + if k > 0, do: lvs[k - 1] |> List.first(), else: 0

    ds = Map.put(ds, j, max(dsi, dsj))
    process2(w, ds, i, j + 1, ws, lvs, n, m)
  end
  def process2(_, ds, _, _, _, _, _, _), do: ds

  def binary_search_vw(lvs, w), do: binary_search_vw(lvs, w, 0, map_size(lvs))
  def binary_search_vw(lvs, w, left, right) when right - left == 1 do
    case {lvs[left], lvs[right]} do
      {[_, ^w], _} -> left
      {_, [_, ^w]} -> right
      {[_, _], nil} -> nil
      {nil, [_, _]} -> nil
      {[_, vl], [_, vr]} ->
        cond do
          vl > w -> left
          vr >= w -> right
        end
    end
  end
  def binary_search_vw(lvs, w, left, right) do
    mid = div(right - left, 2) + left

    with [_, v] <- Map.get(lvs, mid),
          true <- v < w
    do
      binary_search_vw(lvs, w, mid, right)
    else
      _ -> binary_search_vw(lvs, w, left, mid)
    end

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
