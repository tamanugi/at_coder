defmodule PowerPocket.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [a, b] = read_array()

    (b - 1)/(a - 1) |> ceil |> IO.puts()
  end

end
