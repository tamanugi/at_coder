defmodule ProductMax.Main do
  def main() do
    [a, b, c, d] = read_array()

    (for i <- [a, b], j <- [c, d], do: i * j)
    |> Enum.max()
    |> IO.puts()

  end
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

end
