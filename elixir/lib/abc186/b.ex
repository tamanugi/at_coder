defmodule Abc186.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.flat_map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def main() do
    _ = read_array()

    as = read_multi_array()

    mi = Enum.min(as)

    as
    |> Enum.map(fn i -> i - mi end)
    |> Enum.sum()
    |> IO.puts()
  end
end
