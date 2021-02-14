defmodule Arc112.A.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()
  end

  def main() do
    _ = read_single()

    read_multi_array()
    |> Stream.map(&solve/1)
    |> Enum.to_list()
    |> Enum.join("\n")
    |> IO.puts()
  end

  def solve([0, 0]), do: 1
  def solve([l, r]) when 2 * l > r, do: 0
  def solve([l, r]) when 2 * l == r, do: 1
  def solve([l, r]) do
    ll = 2 * l
    1..(r - ll + 1)
    |> Enum.sum()
  end
end
