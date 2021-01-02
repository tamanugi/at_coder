defmodule Bingo.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    bingo =
      1..3
      |> Enum.map(&bingo_card/1)
      |> Enum.reduce(fn m, acc ->
        Map.merge(m, acc)
      end)

    _ = read_single()

    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(fn i -> Map.get(bingo, i) end)
    |> Enum.filter(&(&1 != nil))
    |> Enum.uniq()
    |> check()
    |> IO.puts()
  end

  def bingo_card(y) do
    read_array()
    |> Enum.with_index(1)
    |> Enum.reduce(%{}, fn {n, x}, acc ->
      Map.put(acc, n, {x, y})
    end)
  end

  def check(hits) do
    cond do
      # 縦チェック
      hits |> Enum.frequencies_by(fn {i, _} -> i end) |> Map.values() |> Enum.member?(3) -> "Yes"

      # 横チェック
      hits |> Enum.frequencies_by(fn {_, j} -> j end) |> Map.values() |> Enum.member?(3) -> "Yes"

      # 斜めチェック
      (hits |> Enum.filter(fn {i, j} -> i == j end) |> length()) == 3
        -> "Yes"
      (hits |> Enum.filter(fn e -> e == {3, 1} or e == {2, 2} or e == {1, 3}  end) |> length()) == 3
        -> "Yes"

      true -> "No"
    end
  end

end
