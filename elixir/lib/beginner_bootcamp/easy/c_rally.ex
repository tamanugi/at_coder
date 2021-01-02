defmodule Rally.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    xs = read_array()

    solve(xs)
  end

  def solve(xs) do
    {min, max} = Enum.min_max(xs)

    min..max
    |> Enum.reduce(nil, fn p, acc ->
      min(process(xs, p), acc)
    end)
    |> IO.puts()
  end

  def process(xs, p), do: process(xs, p, 0)

  def process([], _, sum), do: sum
  def process([h | t], p, sum) do
    sum = sum + (abs(h - p) |> pow)
    process(t, p, sum)
  end

  def pow(a), do: a * a

end
