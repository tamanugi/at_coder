defmodule IrreversibleOperation.Main do

  def main() do
    s = IO.read(:line) |> String.trim()

    solve(s)
  end

  def solve(s) do

    ss =
      s
      |> String.split("")
      |> Enum.filter(&(String.length(&1) > 0))

    # Wの出現回数を調べる
    wcount = ss |> Enum.count(fn v -> v == "W" end)
    adjust = 1..wcount |> Enum.sum()

    # Wの出現インデックスの合計から引く
    sum =
      ss
      |> Enum.with_index(1)
      |> Enum.filter(fn {v, _} -> v == "W" end)
      |> Enum.map(fn {_, i} -> i end)
      |> Enum.sum()

    IO.puts(max(0, sum - adjust))
  end

end
