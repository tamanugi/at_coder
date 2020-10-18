defmodule VariousDistances.Main do

  def main() do
    _ = read_single()
    xs = read_array()

    solve1(xs)
    solve2(xs)
    solve3(xs)
  end

  def solve1(xs) do
    xs
    |> Enum.reduce(0, fn x, acc ->
      acc + abs(x)
    end)
    |> IO.puts
  end

  def solve2(xs) do
    xs
    |> Enum.reduce(0, fn x, acc ->
      xx = abs(x) |> pow()
      acc + xx
    end)
    |> :math.sqrt()
    |> IO.puts
  end

  def solve3(xs) do
    {min, max} = xs |> Enum.min_max()
    max(abs(min), abs(max))
    |> IO.puts()
  end

  def pow(n), do: n * n

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

end
