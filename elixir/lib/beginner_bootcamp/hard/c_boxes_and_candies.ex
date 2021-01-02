defmodule BoxesAndCandies.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, x] = read_array()
    as = read_array()

    solve(as, x, 0)
    |> IO.puts()
  end

  def solve([], _, acc), do: acc
  def solve([h], x, acc) do
    if h > x, do: acc + h - x, else: acc
  end
  def solve([h1, h2 | t], x, acc) do
    {h2, acc} =
      case h1 + h2 - x do
        i when i > 0 ->
          {max(h2 - i, 0), acc + i}
        _ -> {h2, acc}
      end

    solve([h2 | t], x, acc)
  end

end
