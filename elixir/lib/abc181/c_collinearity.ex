defmodule Collinearity.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end

  def main() do
    _n = read_single()

    xys = read_multi_array()

    combination(xys, 3)
    |> Enum.reduce_while("No", fn [[x1, y1], [x2, y2], [x3, y3]],_ ->
      a = if x1 != x2, do: (y2 - y1) / (x2 - x1), else: :inf
      b = if x1 != x3, do: (y3 - y1) / (x3 - x1), else: :inf
      if a == b  do
        {:halt, "Yes"}
      else
        {:cont, "No"}
      end
    end)
    |> IO.puts()
  end

end
