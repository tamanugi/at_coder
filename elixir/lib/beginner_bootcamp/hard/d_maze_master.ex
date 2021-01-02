defmodule MazeMaster.Main do

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
      |> Enum.with_index()
      |> Enum.flat_map(fn {s, i} -> split_and_filter(s) |> Enum.with_index() |> Enum.map(fn {v, j} -> {{i, j}, v} end) end)
      |> Map.new()

    (for i <- 0..h, j <- 0..w, do: {i, j})
    |> Enum.filter(fn p -> cell[p] == "." end)
    |> solve(cell, h, w, 0)
    |> IO.puts()
  end

  def solve([], _, _, _, acc), do: acc
  def solve([head | t], cell, h, w, acc) do
    c = bfs({[], [head]}, cell, h, w, %{head => 0})
    acc = max(acc, c)
    solve(t, cell, h, w, acc)
  end

  def bfs({[], []}, _, _, _, acc), do: acc |> Map.values() |> Enum.max()
  def bfs(q, cell, h, w, acc) do
    {{:value, p}, q} = :queue.out(q)

    # 現在位置のコスト
    c = Map.get(acc, p, 0)

    # 周り
    {acc, q} =
      around(p, h, w)
      |> Enum.filter(fn p -> cell[p] == "." end)
      |> Enum.reduce({acc, q}, fn p, {acc, q} ->
        # 移動先のコスト
        v = acc[p]

        if c + 1 < v do
          # キューになければ追加
          q = unless :queue.member(p, q), do: :queue.in(p, q), else: q
          # 移動先のコストを更新した場合
          {Map.put(acc, p, c + 1), q}
        else
          {acc, q}
        end
      end)

    bfs(q, cell, h, w, acc)
  end

  def around({i, j}, h, w) do
    [{0, -1}, {0, 1}, {-1, 0}, {1, 0}]
    |> Enum.map(fn {di, dj} -> {i + di, j + dj} end)
    |> Enum.reject(fn {i, j} -> i < 0 or j < 0 or i >= h or j >= w end)
  end

end
