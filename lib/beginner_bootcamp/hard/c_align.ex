defmodule Align.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
  end

  def main() do
    _ = read_single()
    as = read_multi_array()

    max(solve2(as, :asc), solve2(as, :desc))
    |> IO.puts()
  end

  def solve2(as, sort) do
    as = as |> Enum.sort(sort)
    q = :queue.from_list(as)

    l = solve(q) |> Enum.reverse

    first = List.first(l)
    last = List.last(l)

    # 一回計算する
    {_, p} =
      l
      |> Enum.reduce({0, 0}, fn i, {pre, acc} ->
        acc = if pre == 0, do: 0, else: acc + abs(pre - i)
        {i, acc}
      end)

    find(l, first, last, p, p)
  end

  def permutation(_, 0), do: [[]]
  def permutation(list, n) do
    for x <- list, rest <- permutation(list -- [x], n - 1), do: [x | rest]
  end

  def check(as) do
    as
    |> permutation(length(as))
    |> Enum.map(fn s ->
      {_, sum} =
        s
        |> Enum.reduce({nil, 0}, fn i, {p, acc} ->
          acc = if p == nil, do: 0, else: acc + abs(p - i)
          {i, acc}
      end)
      if sum >= 121 do
        # IO.inspect({s, sum})
      end
      sum
    end)
    |> Enum.max()
  end

  def solve(_, acc \\ [])
  def solve({[], []}, acc), do: acc
  def solve({[v], []}, acc), do: [v | acc]
  def solve({[], [v]}, acc), do: [v | acc]
  def solve(q, acc) do
    {{:value, v1}, q} = :queue.out(q)
    {{:value, v2}, q} = :queue.out_r(q)
    solve(q, [v1, v2 | acc])
  end

  def find([], _, _, _, acc), do: acc
  def find([h], first, last, pre, acc), do: max(acc, pre + abs(last - h) - abs(first - h))
  def find([h, h2 | t], first, last, pre, acc) do
    pre = pre - abs(h - h2) + abs(last - h)
    acc = max(pre, acc)
    find([h2 | t], first, h, pre, acc)
  end
end
