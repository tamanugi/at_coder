defmodule DoubleFactorial.Main do

  require Integer

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    if Integer.is_even(n) do
      solve(n, 10, 0)
    else
      0
    end
    |> IO.inspect()
  end

  def solve(n, i, acc) when i > n, do: acc
  def solve(n, i, acc) do
    acc = acc + div(n, i)
    solve(n, i * 5, acc)
  end

end
