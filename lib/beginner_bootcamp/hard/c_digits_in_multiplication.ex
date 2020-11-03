defmodule DigitsInMultiplication.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    1..(:math.sqrt(n) |> floor)
    |> Enum.filter(&(rem(n, &1) == 0))
    |> Enum.map(fn i -> f(i, div(n, i)) end)
    |> Enum.min()
    |> IO.puts()
  end

  def f(a, b) do
    a = Integer.digits(a) |> Enum.count()
    b = Integer.digits(b) |> Enum.count()

    max(a, b)
  end
end
