defmodule StringEquivalance.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    solve(n)
    |> Enum.sort()
    |> Enum.join("\n")
    |> IO.puts()
  end

  def solve(1), do: ["a"]
  def solve(2), do: ["aa", "ab"]
  def solve(3), do: ["aaa", "aab", "aba", "abb", "abc"]
  def solve(n) do
    solve(n - 1)
    |> Enum.flat_map(fn s ->
      mx = s |> String.to_charlist() |> Enum.max()

      97..(mx+1)
      |> Enum.map(fn c -> s <> <<c::utf8>> end)
    end)

  end

end
