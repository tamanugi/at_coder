defmodule Ki.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(fn s -> String.trim(s) end)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()
  end

  defmodule Tree do

    def new() do
      %{}
    end

    def count(tree, cmap, x, acc \\ 0) do
      px = tree[x]

      case px do
        nil -> acc
        ^x -> acc
        1 ->
          acc + Map.get(cmap, px, 0)
        _ ->
          acc = acc + Map.get(cmap, px, 0)
          count(tree, cmap, px, acc)
      end
    end

    def add(tree, a, b) do
      Map.put(tree, b, a)
    end
  end
  def make_tree(rest, tree, n..n), do: {rest, tree}
  def make_tree([[a, b] | t], tree, i..n) do
    tree = Tree.add(tree, a, b)
    make_tree(t, tree, i+1..n)
  end

  def main() do
    [n, _q] = read_array()
    # {itime, inputs} = :timer.tc(fn -> read_multi_array() end)
    {rest, tree} = read_multi_array() |> make_tree(%{}, 0..n)

    # {tree_time, tree} = :timer.tc(fn -> make_tree(abs, %{}) end)
    # {cmap_time, cmap} = :timer.tc(fn -> count_up(pxs, %{}) end)
    cmap = count_up(rest, %{})

    # IO.inspect(tree_time)
    # IO.inspect(cmap_time)

    1..n+1
    |> solve(tree, cmap, [])
    |> IO.puts()
  end

  def count_up([], acc), do: acc
  def count_up([[p, x] | t], acc) do
    count_up(t, Map.update(acc, p, x, fn i -> i + x end))
  end

  def solve(n..n, _, _, acc), do: acc |> Enum.reverse() |> Enum.join(" ")
  def solve(i..n, tree, cmap, acc) do
    s = Map.get(cmap, i, 0) + Tree.count(tree, cmap, i)
    solve(i+1..n, tree, cmap, [s | acc])
  end

end
