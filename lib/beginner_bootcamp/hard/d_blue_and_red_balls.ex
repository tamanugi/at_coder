defmodule BlueAndRedBalls.Main do
  @mod 1000_000_000 + 7

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, k] = read_array()

    solve(1..k, n, 0, [])
    |> Enum.map(fn {i, r} -> r * split_number(k, i) end)
    |> Enum.map(fn i -> rem(i, @mod) end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  def solve(i..k, _, _, acc) when i > k, do: acc |> Enum.reverse()
  def solve(i..k, n, sum, acc) do
    r = combi(n - k + 1, i)
    solve(i+1..k, n, sum + r, [{i, r} | acc])
  end

  def split_number(_, 0), do: 1
  def split_number(a, b), do: combi(a - 1, b - 1)

  def combi(n, a) when n < a, do: 0
  def combi(n, a) do
    a = if a > div(n, 2), do: n - a, else: a
    x = fac(n, a)
    y = fac(a)
    div x, y
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

  def fac(n), do: fac(n, n, 1)
  def fac(n, i), do: fac(n, i, 1)
	defp fac(0, _, cur), do: cur
	defp fac(_, 0, cur), do: cur
  defp fac(n, i, cur) when n > 0, do: fac(n - 1, i - 1, (cur * n))

  def mod(x, y) when x > 0, do: rem(x, y)
  def mod(x, y) when x < 0, do: mod(y + x, y)
  def mod(0, _), do: 0


end
