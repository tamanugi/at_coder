defmodule Values.Main do
  defmodule UnionFind do

    def new() do
      %{}
    end

    def root(tree, x) do
      px = tree[x]

      case px do
        nil -> {tree, x}
        ^x -> {tree, x}
        _ ->
          {tree, nx} = root(tree, px)
          tree = Map.put(tree, x, nx)
          {tree, nx}
      end
    end

    def unite(tree, x, y) do
      {tree, rx} = root(tree, x)
      {tree, ry} = root(tree, y)
      [rx, ry] = Enum.sort([rx, ry])

      if rx == ry do
        tree
      else
        Map.put(tree, ry, rx)
      end
    end
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

  def main do
    [n, _] = read_array()
    a = read_map()
    b = read_map()

    lines = IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()

    tree =
      lines
      |> Enum.reduce(%{}, fn [c, d], tree ->
        UnionFind.unite(tree, c, d)
      end)

    res =
      1..n
      |> Enum.reduce(%{}, fn i, groups ->
        {_, r} = UnionFind.root(tree, i)

        Map.update(groups, r, [i], fn v -> [i | v] end)
      end)
      |> Map.values()
      |> Enum.reduce_while(true, fn g, _ ->
        as =  g |> Enum.map(&Map.get(a, &1 - 1)) |> Enum.sum()
        bs = g |> Enum.map(&Map.get(b, &1 - 1)) |> Enum.sum()
        if as == bs, do: {:cont, true}, else: {:halt, false}
      end)

    if res do
      "Yes"
    else
      "No"
    end
    |> IO.puts()
  end

end
