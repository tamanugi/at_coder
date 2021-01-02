defmodule DivRemNumber.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    solve(n)
    |> IO.puts()
  end

  def solve(n) do
    m = :math.sqrt(n) |> floor()

    1..m
    |> Enum.filter(fn i -> rem(n, i) == 0 end)
    |> Enum.map(fn i -> div(n, i) - 1 end)
    |> Enum.filter(fn i -> i > 0 end)
    |> Enum.filter(fn i -> div(n, i) == rem(n, i) end)
    |> Enum.sum()
  end

end
