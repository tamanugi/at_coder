defmodule Quadruple.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, k] = read_array()
    k = abs(k)
    (for a <- (2 * n)..(k + 2), do: p(a, n) * p(a - k, n))
    |> Enum.sum()
    |> IO.inspect()

  end

  def p(n, k) do
    s = (n - k - 1)
    s = if s > 0, do: s, else: 0
    (n - 1) - (s * 2)
  end
end
