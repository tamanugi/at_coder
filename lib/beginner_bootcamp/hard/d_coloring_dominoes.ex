defmodule ColoringDominoes.Main do
  @mod 1000000007

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    _ = read_single()

    s1 = IO.read(:line) |> String.trim() |> String.codepoints()
    s2 = IO.read(:line) |> String.trim() |> String.codepoints()

    Enum.zip(s1, s2)
    |> solve()
    |> IO.puts()
  end

  def solve([{a, b}, {a, b} | t]), do: solve(t, :h, 6)
  def solve([{s, s} | t]), do: solve(t, :v, 3)

  def solve([], _, acc), do: acc
  def solve([{a, b}, {a, b} | t], p, acc) do
    acc =
      case p do
        :v -> acc * 2
        :h -> acc * 3
      end
      |> rem(@mod)

    solve(t, :h, acc)
  end
  def solve([{s, s} | t], p, acc) do
    acc =
      case p do
        :v -> acc * 2
        :h -> acc
      end
      |> rem(@mod)

    solve(t, :v, acc)
  end
end
