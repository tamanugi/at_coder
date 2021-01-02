defmodule FaceProducesUnhappiness.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, k] = read_array()
    s = IO.read(:line) |> String.trim() |> String.codepoints()
    a = solve(s, 0)

    (n - 1 - max((a - 2 * k), 0))
    |> IO.puts()
  end

  def solve([], acc), do: acc
  def solve([_], acc), do: acc
  def solve([h1, h2 | t], acc) do
    acc = if h1 != h2, do: acc + 1, else: acc
    solve([h2 | t], acc)
  end

end
