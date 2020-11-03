defmodule DisjointSetofCommonDivisors.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [a, b] = read_array()

    gcd = Integer.gcd(a, b)

    if gcd > 1 do
      # gcdの約数
      1..(:math.sqrt(gcd) |> floor())
      |> Enum.filter(&(rem(gcd, &1) == 0))
      |> Enum.flat_map(fn i -> [i, div(gcd, i)] end)
      |> Enum.sort()
      |> solve([])
    else
      1
    end
    |> IO.puts()
  end

  def solve([], acc), do: acc |> Enum.count()
  def solve([1 | t], acc), do: solve(t, [1 | acc])
  def solve([h | t], acc) do
    t = t |> Enum.reject(&(rem(&1, h) == 0))
    solve(t, [h | acc])
  end

end
