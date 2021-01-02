defmodule LinePP.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, x, y] = read_array()

    count =
      (for i <- 1..n, j <- 1..n, i != j and i < j, do: {i, j})
      |> Enum.map(fn {i, j} -> min(j - i, abs(j - y) + 1 + abs(x - i)) end)
      |> Enum.frequencies()

    1..(n - 1)
    |> Enum.map(fn i -> Map.get(count, i, 0) end)
    |> Enum.join("\n")
    |> IO.puts()
  end


end
