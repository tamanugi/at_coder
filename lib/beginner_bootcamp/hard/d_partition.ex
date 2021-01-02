defmodule Partition.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end
  def div_and_rem(m, n) do
    {div(m, n), rem(m, n)}
  end

  def main() do
    [n, m] = read_array()

    case div_and_rem(m, n) do
      {a, 0} -> a
      {a, _} ->
        Stream.iterate(1, &(&1 + 1))
        |> Stream.take_while(&(&1 <= (:math.sqrt(m) |> floor)))
        |> Stream.filter(fn i -> rem(m, i) == 0 end)
        |> Stream.flat_map(fn i -> [i, div(m, i)] end)
        |> Enum.sort()
        |> Enum.filter(fn i -> i <= a end)
        |> Enum.reduce(1, fn i, acc ->
          if rem(m - (n - 1) * i, i) == 0, do: i, else: acc
        end)
    end
    |> IO.puts()
  end
end
