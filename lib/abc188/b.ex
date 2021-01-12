defmodule Abc188.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    as = read_array()
    bs = read_array()

    solve(as, bs, 0)
    |> IO.puts()
  end

  def solve([], [], 0), do: "Yes"
  def solve([], [], _), do: "No"
  def solve([a | at], [b | bt], acc), do: solve(at, bt, acc + (a * b))
end
