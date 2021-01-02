defmodule Twiblr.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [a, b] = read_array()
    (( 2 * a + 100 ) - b)
    |> IO.puts()
  end

end
