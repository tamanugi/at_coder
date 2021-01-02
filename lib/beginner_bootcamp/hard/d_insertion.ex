defmodule Insertion.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    _ = read_single()
    s = IO.read(:line) |> String.trim()
    ss = s |> String.codepoints()

    {a, b} = solve(ss, {0, 0})

    String.duplicate("(", abs(b)) <> s <> String.duplicate(")", abs(b) + a)
    |> IO.puts()
  end

  def solve([], acc), do: acc
  def solve([h | t], {a, b}) do
    a =
      case h do
        "(" -> a + 1
        ")" -> a - 1
      end
    solve(t, {a, min(a, b)})
  end

end
