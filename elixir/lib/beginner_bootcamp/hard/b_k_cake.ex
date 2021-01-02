defmodule KCake.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main do
    [_, _] = read_array()
    as = read_array() |> Enum.sort(:desc)

    [mx | rest] = as
    max(0, mx - Enum.sum(rest) - 1)
    |> IO.puts()
  end

end
