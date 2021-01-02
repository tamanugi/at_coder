defmodule Triangle.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    s = read_single()


    # 座標の三角形の公式
    # |x2 * y3 - x3 * y2| = S

    # (x2, y2) = (10^9, 1)と固定する
    # 10^9 * y3 - x3 = s

    v = 1000_000_000
    x3 = rem(v - rem(s, v), v)
    [0, 0, v, 1, x3, div(s + x3, v)]
    |> Enum.join(" ")
    |> IO.puts()
  end
end
