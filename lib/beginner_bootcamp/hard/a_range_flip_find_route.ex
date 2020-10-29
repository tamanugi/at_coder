defmodule RangeFlipFindRoute.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def split_and_filter(s) do
    s
    |> String.split("")
    |> Enum.filter(&(String.length(&1) > 0))
  end

  def main() do
    [h, w] = read_array()

    cell =
      IO.read(:all)
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.flat_map(&split_and_filter/1)

    # スタート位置のコスト
    costs = (for i <- 1..(h * w)-1, into: %{}, do: {i, 1000_000})
    init_cost = if Enum.at(cell, 0) == "#", do: 1, else: 0
    costs = Map.put(costs, 0, init_cost)

    q = :queue.in(0, :queue.new)

    solve(q, costs, cell, h * w, w)
    |> IO.puts()
  end

  def solve({[], []}, costs, _, size, _), do: Map.get(costs, size - 1)
  def solve(q, costs, cell, size, w) do
    # キューから取り出す
    {{:value, p}, q} = :queue.out(q)

    # 現在位置のコスト
    c = costs[p]

    # 右と下を確認する
    # 右
    {q, costs} =
      if rem(p + 1, w) != 0 do
        check(Enum.at(cell, p + 1), p + 1, q, costs, c)
      else
        # 右端の場合
        {q, costs}
      end

    # 下
    {q, costs} =
      if p + w < size do
        check(Enum.at(cell, p + w), p + w, q, costs, c)
      else
        # 下の場合
        {q, costs}
      end

    solve(q, costs, cell, size, w)
  end

  def check(".", p, q, costs, c) do
    cost = costs[p]
    if cost > c do
      costs = Map.put(costs, p, c)
      {:queue.in_r(p, q), costs}
    else
      {q, costs}
    end
  end
  def check("#", p, q, costs, c) do
    cost = costs[p]
    if cost > c + 1 do
      costs = Map.put(costs, p, c + 1)
      {:queue.in(p, q), costs}
    else
      {q, costs}
    end
  end

end
