defmodule Sumitrust2019.D.Main do
  def read_single() do
    IO.read(:line) |> String.trim()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    s = read_single()

    # 各文字の出現位置
    number_pos_map =
      s
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {si, idx}, acc ->
        Map.update(acc, String.to_integer(si), [idx], fn current -> [idx | current] end)
      end)

    # 000 - 999 まで全探索する
    for i <- 0..9, j <- 0..9, k <- 0..9 do
      pos_i = Map.get(number_pos_map, i, []) |> Enum.reverse() |> List.first()
      pos_j = Map.get(number_pos_map, j, []) |> Enum.reverse() |> Stream.filter(& &1 > pos_i) |> Enum.take(1) |> List.first()
      pos_k = Map.get(number_pos_map, k, []) |> Enum.reverse() |> Stream.filter(& &1 > pos_j) |> Enum.take(1) |> List.first()

      if pos_i == nil or pos_j == nil or pos_k == nil, do: 0, else: 1
    end
    |> Enum.sum()
    |> IO.puts()
  end
end
