defmodule Abc263.A.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    cards = read_array()

    cards
    |> Enum.frequencies()
    |> Map.values()
    |> (fn
      [2, 3] -> "Yes"
      [3, 2] -> "Yes"
      _ -> "No"
    end).()
    |> IO.puts()
  end
end
