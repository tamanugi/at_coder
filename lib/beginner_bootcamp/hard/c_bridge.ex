defmodule Bridge.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()
  end

  defmodule UnionFind do

    def new() do
      %{}
    end

    def rootx(tree, x) do
      px = tree[x]

      case px do
        nil -> x
        ^x -> x
        _ ->
          rootx(tree, px)
      end
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

    abs = read_multi_array()

    solve([[0, 0] | abs], [], n, 0)
    |> IO.inspect(charlists: :as_lists)
  end

  def solve([], _, _, acc), do: acc
  def solve([h | t], tmp, n, acc) do
    tree = union(t, %{})
    tree = union(tmp, tree)

    acc =
      1..n
      |> Enum.map(fn i -> UnionFind.rootx(tree, i) end)
      |> Enum.uniq()
      |> Enum.count()
      |> (fn
        1 -> acc
        _ -> acc + 1
      end).()

      solve(t, [h | tmp], n, acc)
  end

  def union([], tree), do: tree
  def union([[a, b] | t], tree) do

    tree = UnionFind.unite(tree, a, b)

    union(t, tree)
  end

end
