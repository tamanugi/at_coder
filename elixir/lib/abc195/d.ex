defmodule Abc195.D.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, _m, q] = read_array()

    # 価値順に並べておく
    wv = 1..n |> Enum.map(fn _ -> read_array() end) |> Enum.sort_by(fn [_w, v] -> v end, :desc)
    # 大きさ順に並べておく
    boxes = read_array() |> Enum.with_index(1) |> Enum.sort_by(fn {x, _} -> x end)

    1..q
    |> Enum.map(fn _i -> read_array() end)
    |> solve(wv, boxes, [])
    |> IO.puts()
  end

  def solve([], _wv, _boxes, acc1), do: acc1 |> Enum.reverse() |> Enum.join("\n")
  def solve([[l, r] | rest], wv, boxes, acc1) do
    # 使えない区間を排除する
    b = boxes |> Enum.reject(fn {_, i} -> l <= i and i <= r end)

    # 箱に入れていく
    {_, vvv} =
      b
      |> Enum.reduce({wv, 0}, fn ({x, _}, {wv, acc}) ->
        {vvv, wv} =  process(wv, x, [])
        {wv, acc + vvv}
      end)

    solve(rest, wv, boxes, [vvv | acc1])
  end

  def process([], _x, tmp), do: {0, tmp |> Enum.reverse()}
  def process([[w, v] | rest], x, tmp) do
    if w <= x do
      {v, Enum.reverse(tmp) ++ rest}
    else
      process(rest, x, [[w, v] | tmp])
    end
  end
end
