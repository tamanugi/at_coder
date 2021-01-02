defmodule TrapezoidSum.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do

    _ = read_single()

    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Stream.map(fn [a, b] -> Enum.sum(a..b) end)
    |> Enum.to_list()
    |> Enum.sum()
    |> IO.puts()
  end

end
