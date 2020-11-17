defmodule Wall.Main do

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

  def main() do
    [_, _] = read_array()

    mp =
      (for i <- 0..9, do: {i, read_map()})
      |> Map.new()

    minmap = move({[1],[]}, mp, %{})

    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(fn s -> s |> String.split(" ") end)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
    |> Enum.filter(fn i -> i != -1 and i != 1 end)
    |> Enum.map(fn i -> minmap[i] end)
    |> Enum.sum()
    |> IO.puts()

  end

  def move({[], []}, _, acc), do: acc
  def move(q, mp, acc) do
    {{:value, v}, q} = :queue.out(q)

    cost = Map.get(acc, v, 0)

    # 現在位置から暫定コストより少ないコストで移動できるところ
    nexts =
      0..9
      |> Enum.filter(&(&1 != 1))
      |> Enum.map(fn i -> {i, mp[i][v]} end)
      |> Enum.filter(fn {to, c} -> c > 0 and c + cost < acc[to] end)

    # キューに追加
    q =
      nexts
      |> Enum.map(fn {to, _} -> to end)
      |> Enum.reduce(q, fn i, q -> :queue.in_r(i, q) end)

    # コストを更新
    acc =
      nexts
      |> Enum.reduce(acc, fn {to, c}, acc ->
        Map.put(acc, to, cost + c)
      end)

    move(q, mp, acc)
  end

end
