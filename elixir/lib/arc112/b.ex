defmodule Arc112.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [b, c] = read_array()

    solve(b, c)
    |> IO.inspect()
  end

  def solve(b, c) when b < 0 do
    # p3を求める
    p3 = max(b - div(c - 1, 2), 0)

    # p4を求める
    p4 = abs(b - div(c - 1, 2))

    # p1を求める
    p1 = b - div(c, 2)

    # p2を求める
    p2 = max(-1 * b - div(c - 2, 2), 0)

    z = if p2 == 0 and p3 == 0, do: -1, else: 0
    (abs(p1 - p2) + 1) + (p4 - p3 + 1) + z
  end

  def solve(b, c) when b == 0 do
    # p3を求める
    p3 = max(b - div(c, 2), 0)

    # p4を求める
    p4 = b + div(c - 2, 2)

    # p1を求める
    p1 = b - div(c, 2)

    # p2を求める
    p2 = -1 * max(b - div(c - 1, 2), 0)

    z = if p2 == 0 and p3 == 0, do: -1, else: 0
    (abs(p1 - p2) + 1) + (p4 - p3 + 1) + z
  end

  def solve(b, c) do
    # p3を求める
    p3 = max(b - div(c, 2), 0)

    # p4を求める
    p4 = b + div(c - 2, 2)

    # p1を求める
    p1 = -1 * b - div(c - 1, 2)

    # p2を求める
    p2 = -1 * max(b - div(c - 1, 2), 0)

    z = if p2 == 0 and p3 == 0, do: -1, else: 0
    (abs(p1 - p2) + 1) + (p4 - p3 + 1) + z
  end
end
