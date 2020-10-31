defmodule Agc40A.Main do

  def main() do
    s =
      IO.read(:line)
      |> String.trim()
      |> String.split("")
      |> Enum.filter(&(String.length(&1) > 0))

    # 各点で左に<が何個あるかカウントする
    left =
      s
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {c, i}, acc ->
        if c == "<" do
          Map.put(acc, i + 1, Map.get(acc, i, 0) + 1)
        else
          acc
        end
      end)

    # 各点で右に>が何個あるかカウントする
    n = length(s)
    right =
      s
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {c, i}, acc ->
        if c == ">" do
          Map.put(acc, n - i - 1 , Map.get(acc, n - i, 0) + 1)
        else
          acc
        end
      end)

    solve(left, right, 0, n, 0)
    |> IO.inspect()
  end

  def solve(_, _, i, n, acc) when i > n, do: acc
  def solve(l, r, i, n, acc) do
    c = max(Map.get(l, i, 0), Map.get(r, i, 0))
    solve(l, r, i + 1, n, acc + c)
  end
end
