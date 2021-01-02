defmodule CollectingBallsEasy.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    k = read_single()
    xs = read_array()

    solve(xs, k, 0)
    |> IO.puts()
  end

  def solve([], _, acc), do: acc
  def solve([h | t], k, acc) do
    acc = acc + min(2 * h, 2 * abs(h - k))
    solve(t, k, acc)
  end
end
