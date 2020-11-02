defmodule Hachi.Main do
  def permutation(_, 0), do: [[]]

  def permutation(list, n) do
    for x <- list, rest <- permutation(list -- [x], n - 1), do: [x | rest]
  end

  def main() do

    s =
      IO.read(:line)
      |> String.trim()
      |> String.split("")
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies
      |> Map.to_list()
      |> Enum.map(fn {i, c} ->
        count = min(3, c)
        for _ <- 1..count, do: i
      end)
      |> List.flatten()

    s
    |> permutation(min(3, length(s)))
    |> Enum.reduce_while("No", fn a, _ ->
      cond do
        Integer.undigits(a) |> rem(8) == 0 -> {:halt, "Yes"}
        true -> {:cont, "No"}
      end
    end)
    |> IO.puts()

  end

end
