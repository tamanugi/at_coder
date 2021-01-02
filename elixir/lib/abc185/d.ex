defmodule Abc185.D.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, m] = read_array()
    unless m == 0 do
      s = read_array() |> Enum.sort(:desc)
      s = [n + 1 | s]

      case solve(s, nil, []) do
        {_, []} -> 0
        {k, distances} ->
          solve2(distances, k, 0)
      end
    else
      1
    end
    |> IO.puts()
  end

  def solve2([], _, acc), do: acc
  def solve2([h | t], k, acc) do
    acc =
      case {div(h, k), rem(h, k)} do
        {c, 0} -> acc + c
        {c, _} -> acc + c + 1
      end

    solve2(t, k, acc)
  end

  def solve([], mi, acc), do: {mi, acc}
  def solve([1], mi, acc), do: {mi, acc}
  def solve([h], mi, acc) do
    d = h - 1
    {min(d, mi), [d | acc]}
  end
  def solve([h1, h2 | t], mi, acc) do
    case h1 - h2 - 1 do
      0 ->
        solve([h2 | t], mi, acc)
      d ->
        solve([h2 | t], min(d, mi), [d | acc])
    end
  end
end
