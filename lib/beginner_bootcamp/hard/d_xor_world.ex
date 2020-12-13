defmodule XorWorld.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [a, b] = read_array()

    c = b |> Integer.digits(2) |> Enum.count()

    c..1
    |> Enum.map(fn i -> count(b, i) - count(a - 1, i) end)
    |> Enum.map(fn i -> rem(i, 2) end)
    |> Integer.undigits(2)
    |> IO.puts()

  end

  def count(n, i) do
    p = :math.pow(2, i) |> floor()
    (div(p, 2) * div(n, p))  + max(rem(n, p) - (div(p, 2) - 1), 0)
  end

end
