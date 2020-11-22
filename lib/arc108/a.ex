defmodule Arc108.A.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [s, p] = read_array()

    solve(s, p)
    |> IO.puts()
  end

  def solve(s, p) do
    b = :math.sqrt(p) |> floor()

    1..b
    |> Enum.filter(fn i -> rem(p, i) == 0 end)
    |> Enum.map(fn i -> {i, div(p, i)} end)
    |> Enum.filter(fn {i, j} -> i + j == s end)
    |> Enum.map(fn _ -> "Yes" end)
    |> Enum.at(0, "No")
  end

end
