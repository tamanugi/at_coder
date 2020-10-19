defmodule TravelingSalesman.Main do
  use Bitwise

  def main() do
    n = read_single()
    cities =
       read_multi_array()
       |> read_map(0, %{})
       |> IO.inspect()

    # cost計算する
    costs = cost(n, cities) |> IO.inspect()

    # 都市0 -> 都市iへの行き先を初期状態として持つ
    dp =
      1..(n - 1)
      |> Enum.reduce(%{}, fn i, acc ->
        Map.put(acc,  i, %{bit([0, i]) => costs[{0, i}]})
      end)
      |> IO.inspect()

    1..((1 <<< n ) - 1)
    |> Enum.filter(fn s -> (s &&& 1) == 1 end)
    |> Enum.reduce(dp, fn s, dp ->
      0..(n - 1)
      |> Enum.filter(fn i -> (s &&& (1 <<< i)) == 1 end)
      |> Enum.reduce(dp, fn i, dp ->

        0..(n - 1)
        |> Enum.filter(fn j -> i != j end)
        |> Enum.reduce(dp, fn j, dp ->
          cost = costs[{i, j}]
          key = s ||| (1 <<< j)
          IO.inspect(key, label: "s=#{s} i=#{i} j=#{j}")
          Map.update(dp, i, %{key => cost}, fn m -> Map.update(m, key, cost, fn cc -> min(cc, cost) end) end)
        end)
      end)
    end)
    |> IO.inspect()
  end

  def solve() do

  end

  def cost(n, cities) do
    (for i <- 0..(n - 1), j <- 0..(n - 1), i != j, do: {i, j})
    |> Enum.reduce(%{}, fn {i, j}, acc ->
      [a, b, c] = Map.get(cities, i)
      [p, q, r] = Map.get(cities, j)

      c = abs(p - a) + abs(q - b) + max(0, r - c)
      Map.put(acc, {i, j}, c)
    end)

  end

  def read_map([], _, acc), do: acc
  def read_map([h|t], i, acc) do
    acc = Map.put(acc, i, h)
    read_map(t, i + 1, acc)
  end

  def bit(nums) when is_list(nums) do
    nums
    |> Enum.reduce(0, fn i, acc -> acc + (:math.pow(2, i) |> floor) end)
  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

end
