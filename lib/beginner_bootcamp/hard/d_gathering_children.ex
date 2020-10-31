defmodule GatheringChildren.Main do

  def main() do
    s = IO.read(:line) |> String.trim() |> String.split("") |> Enum.filter(&(String.length(&1) > 0))

    # 各点で左にRが何個あるかカウントする
    left =
      s
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {c, i}, acc ->
        if c == "R" do
          Map.put(acc, i + 1, Map.get(acc, i, 0) + 1)
        else
          acc
        end
      end)

    # 各点で右にLが何個あるかカウントする
    n = length(s)
    right =
      s
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {c, i}, acc ->
        if c == "L" do
          Map.put(acc, n - i - 2, Map.get(acc, n - i - 1, 0) + 1)
        else
          acc
        end
      end)

    solve(Enum.with_index(s), left, right, [])
    |> Enum.join(" ")
    |> IO.puts()
  end


  def solve([], _, _, acc), do: acc |> Enum.reverse()
  def solve([{c, i} | t], l, r, acc) do

    ri = Map.get(r, i, 0)
    li = Map.get(l, i, 0)

    v =
      cond do
        c == "R" and ri > 0 -> div(ri, 2) + div(li, 2) + 1
        c == "L" and li > 0 -> div(ri, 2) + div(li, 2) + 1
        true -> 0
      end

    solve(t, l, r, [v | acc])
  end

end
