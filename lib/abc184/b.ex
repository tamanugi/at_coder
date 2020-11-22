defmodule Abc184.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, x] = read_array()
    s = IO.read(:line) |> String.trim()

    solve(s, x)
    |> IO.puts()
  end

  def solve("", x), do: x
  def solve("o" <> rest, x), do: solve(rest, x + 1)
  def solve("x" <> rest, x) do
    x = if x > 0, do: x - 1, else: 0
    solve(rest, x)
  end
end
