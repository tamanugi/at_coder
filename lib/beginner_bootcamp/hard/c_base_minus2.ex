defmodule BaseMinus2.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    read_single()
    |> solve()
    |> Enum.join()
    |> IO.puts()
  end

  def solve(0), do: [0]
  def solve(n), do: solve(n, [])
  def solve(0, acc), do: acc
  def solve(n, acc) do
    r = rem(n, -2) |> abs()
    solve(div(n - r, -2), [r | acc])
  end
end
