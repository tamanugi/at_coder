defmodule MakeTriangle.Main do

  def main() do
    n = read_single()
    ls = read_array()

    if n >= 3 do
      solve(ls)
    else
      0
    end
    |> IO.puts()
  end

  def solve(ls) do
    ls
    |> combination(3)
    |> solve(0)
  end

  def solve([], acc), do: acc
  def solve([[i, j, k] | t], acc) when i != j and j != k and i != k do
    [i, j, k] = Enum.sort([i, j, k])

    if i + j > k do
      solve(t, acc + 1)
    else
      solve(t, acc)
    end
  end
  def solve([_ | t], acc), do: solve(t, acc)

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end

end
