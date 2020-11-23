defmodule Knight.Main do
  @mod 1000_000_000 + 7

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [x, y] = read_array()

    combi(x+y, x)
    |> mod(@mod)
    |> IO.inspect()
  end

  def combi(n, a) do
    x = fac(n, a)
    y = fac(a) |> pow(@mod - 2)
    rem(x * y, @mod)
  end
  def pow(_, 0), do: 1
  def pow(m, 2), do: rem(m * m, @mod)
  def pow(m, n) do
    case div_and_rem(n, 2) do
      {a, 0} -> pow(m, a) |> pow(2)
      {a, 1} -> (pow(m, a) |> pow(2)) * m
    end
    |> rem(@mod)
  end
  def div_and_rem(m, n) do
    {div(m, n), rem(m, n)}
  end

  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end
    def permutation(_, 0), do: [[]]

  def permutation(list, n) do
    for x <- list, rest <- permutation(list -- [x], n - 1), do: [x | rest]
  end

  def fac(n), do: fac(n, n, 1)
  def fac(n, i), do: fac(n, i, 1)
	defp fac(0, _, cur), do: cur
	defp fac(_, 0, cur), do: cur
  defp fac(n, i, cur) when n > 0, do: fac(n - 1, i - 1, rem(cur * n, @mod))

  def mod(x, y) when x > 0, do: rem(x, y)
  def mod(x, y) when x < 0, do: mod(y + x, y)
  def mod(0, _), do: 0

end
