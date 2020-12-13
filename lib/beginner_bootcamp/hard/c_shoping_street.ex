defmodule ShoppingStreet.Main do
  use Bitwise

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()

    fs = 1..n |> Enum.map(fn _ -> read_array() |> Enum.with_index(1) end) |> Enum.with_index(1) |> Enum.map(fn {v, i} -> {i, v} end) |> Map.new()
    ps = 1..n |> Enum.map(fn _ -> read_array() end) |> Enum.with_index(1) |> Enum.map(fn {v, i} -> {i, v} end) |> Map.new()

    solve(1, n, fs, ps, -1000_000_000_000)
    |> IO.puts()
  end

  def solve(1024, _, _, _, acc), do: acc
  def solve(i, n, fs, ps, acc) do
    inputs =
      i
      |> Integer.digits(2)
      |> Enum.reverse()
      |> Enum.with_index(1)
      |> Enum.filter(fn {v, _} -> v == 1 end)
      |> Enum.map(fn {_, i} -> i end)

    s =
      1..n
      |> Enum.map(fn i ->
        # 店iとかぶっている時間の個数
        c = fs[i] |> Enum.filter(fn {v, time} -> v == 1 and Enum.member?(inputs, time) end) |> Enum.count()

        # 店iとのかぶっている利益
        ps[i] |> Enum.at(c)
      end)
      |> Enum.sum()

    acc = max(acc, s)
    solve(i + 1, n, fs, ps, acc)
  end

end
