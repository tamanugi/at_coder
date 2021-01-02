defmodule BinomialCoefficients.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()

    as = read_array() |> Enum.sort(:desc)

    [a | rest] = as

    n = div(a, 2)

    b =
     rest
     |> Enum.max_by(fn i -> if i > n, do: a - i, else: i end)

    IO.puts("#{a} #{b}")
  end

end
