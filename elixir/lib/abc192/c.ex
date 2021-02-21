defmodule Abc192.C.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, k] = read_array()

    solve(n, k)
    |> IO.puts()
  end

  def solve(x, 0), do: x
  def solve(x, k) do
    arr = x |> Integer.digits()

    a = arr |> Enum.sort(:desc) |> Integer.undigits()
    b = arr |> Enum.sort(:asc) |> Integer.undigits()

    x = a - b
    solve(x, k - 1)
  end
end
