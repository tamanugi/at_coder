defmodule Abc088B.Main do

  require Integer

  def main() do
    _ = IO.read(:line)
    cards = IO.read(:line) |> String.split(" ") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)

    solve(cards)
    |> IO.puts()

  end

  def solve(cards) do

    cards
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {point, index}, acc ->
      # 偶数番目に高いものはAliceが選択する
      p  = if Integer.is_even(index), do: point, else: -1 * point
      acc + p
    end)

  end

end
