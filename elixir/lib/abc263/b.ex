defmodule Abc263.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
     n = read_single()
     p = read_array() |> List.to_tuple()

     solve(p, elem(p, n - 2), 1)
     |> IO.puts()
  end

  def solve(_, 1, ans), do: ans
  def solve(p, i, ans) do
    solve(p, elem(p, i - 2), ans + 1)
  end
end
