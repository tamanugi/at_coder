defmodule LinearApproximation.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()
    as = read_array() |> Enum.with_index(1)

    b =
      as
      |> Enum.map(fn {v, i} -> v - i end)
      |> Enum.sort()
      |> median(n)

    as
    |> Enum.reduce(0, fn {v, i}, acc -> acc + abs(v - (b + i)) end)
    |> IO.puts()
  end

  def median(list, n) do
    case rem(n, 2) do
      1 ->
        Enum.at(list, div(n, 2))

      0 ->
        a = Enum.at(list, div(n, 2))
        b = Enum.at(list, div(n, 2) - 1)
        div(a + b, 2)
    end

  end

end
