defmodule Redistribution.Main do
  @mod 1000_000_007

  def main() do
    s = read_single()

    if s >= 3 do
      solve(3, s)
    else
      0
    end
    |> IO.puts()
  end

  def solve(3, s) do
    solve(4, s, [1, 0, 0])
  end
  def solve(i, s, [h1 | _]) when i == s + 1, do: h1
  def solve(i, s, [h1, h2, h3 | _]) do
    d = rem(h1 + h3, @mod)
    solve(i + 1, s, [d, h1, h2, h3])
  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end
end
