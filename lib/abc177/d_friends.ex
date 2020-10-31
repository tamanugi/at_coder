defmodule Friends.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

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


  def main() do
    [n, _] = read_array()
    tree = UnionFind.new()

    abs = IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()

    tree = abs
    |> Enum.reduce(tree, fn [i, j],acc ->
      UnionFind.unite(acc, i, j)
    end)

    {_, roots} =   1..n
    |> Enum.reduce({tree, []}, fn i, {tree, acc} ->
      {tree, count} = UnionFind.root(tree, i)
      {tree, [count | acc]}
    end)
    roots
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.max
    |> IO.puts()
  end
end
