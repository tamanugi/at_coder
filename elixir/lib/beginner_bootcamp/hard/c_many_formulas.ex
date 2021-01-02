defmodule ManyFormulas.Main do
  import Bitwise

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    s = IO.read(:line) |> String.trim()

    n = String.length(s)

    1..(1 <<< n - 1)
    |> Enum.flat_map(fn i -> solve(i, s) end)
    |> Enum.map(fn
      "" -> 0
      c -> String.to_integer(c)
    end)
    |> Enum.sum()
    |> IO.puts()

  end

  def solve(i, s) do

    splits =
      i
      |> Integer.digits(2)
      |> Enum.reverse()
      |> Enum.with_index(1)
      |> Enum.filter(fn {v, _} -> v == 1 end)
      |> Enum.map(fn {_, i} -> i end)

    split(s, 0, splits)
  end

  def split(s, _, []), do: [s]
  def split(s, p, [h | t]) do
    {l, r} = String.split_at(s, h - p)
    split(r, h, t) ++ [l]
  end

end
