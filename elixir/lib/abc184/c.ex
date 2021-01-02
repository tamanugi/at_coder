defmodule Abc184.C.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [r1, c1] = read_array()
    [r2, c2] = read_array()

    # 2点の距離を求める
    d = distance([r1, c1], [r2, c2])

    cond do
      d == 0 -> 0
      d <= 3 -> 1
      r1 + c1 == r2 + c2 -> 1
      r1 - c1 == r2 - c2 -> 1
      d <= 6 -> 2

      # 周囲に動いて + 斜めに行くパターン
      distance([r1, c1], [r1, c2 - (r2 - r1)]) <= 3 -> 2
      distance([r1, c1], [r1, c2 + (r2 - r1)]) <= 3 -> 2

      # 斜めがかぶる時
      rem(abs(r1 + c1), 2) == rem(abs(r2 + c2), 2) -> 2

      # それ以外
      true -> 3
    end
    |> IO.puts()
  end

  def distance([a, b], [c, d]) do
    abs(c - a) + abs(d - b)
  end
end
