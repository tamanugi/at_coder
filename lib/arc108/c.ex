defmodule Arc108.C.Main do

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, _] = read_array()
    tree =
      read_multi_array()

    g =  tree |> graph(%{})

    map = solve({[1], []}, g, n, %{1 => 1})

    1..n
    |> Enum.map(fn i -> map[i] end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  def graph([], acc), do: acc
  def graph([[u, v, c] | t], acc) do
    [u, v] = Enum.sort([u, v])
    acc =
      acc
      |> Map.update(u, [[v, c]], fn val -> [[v, c]| val] end)
      |> Map.update(v, [[u, c]], fn val -> [[u, c]| val] end)

    graph(t, acc)
  end

  def solve({[], []}, _, _, acc), do: acc
  def solve(q, graph, n, acc) do
    {{:value, cur}, q} = :queue.out(q)
    vn = acc[cur]

    list = graph[cur] |> Enum.filter(fn [v, _] -> acc[v] == nil end)

    acc =
      list
      |> Enum.reduce(acc, fn [v, c], acc ->
        if vn == c do
          Map.put(acc, v, rem(vn, n) + 1)
        else
          Map.put(acc, v, c)
        end
      end)

    q = list |> Enum.reduce(q, fn [v, _], q -> :queue.in(v, q) end)

    solve(q, graph, n, acc)
  end
end
