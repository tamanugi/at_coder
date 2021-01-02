defmodule ColorfulHats.Main do

  @mod 1000_000_000 + 7

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    as = read_array()

    solve(as, %{-1 => 3}, 1)
    |> IO.puts()
  end

  def solve([], _, acc), do: acc
  def solve([h | t], m, acc) do
    # 自分の一個前が何回出たか
    p = Map.get(m, h - 1)

    # 自分が何回出たか
    c = Map.get(m, h, 0)

    unless p == nil do

      acc = acc * max(p - c, 0)
      acc = rem(acc, @mod)

      # 出現回数更新
      m = Map.put(m, h, c + 1)

      solve(t, m, acc)
    else
      0
    end
  end

end
