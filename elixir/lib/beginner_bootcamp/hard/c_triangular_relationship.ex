defmodule TriangularRelationship.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, k] = read_array()

    solve(n, k)
    |> IO.puts()
  end

  def solve(n, k) when rem(k, 2) == 0 do
    a = div(n, k)
    b = div(n + div(k, 2), k)

    a * a * a + b * b * b
  end

  def solve(n, k) when rem(k, 2) == 1 do
    a = div(n, k)
    a * a * a
  end
end
