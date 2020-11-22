defmodule Abc184.A.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [a, b] = read_array()
    [c, d] = read_array()

    IO.puts(a * d - b * c)
  end
end
