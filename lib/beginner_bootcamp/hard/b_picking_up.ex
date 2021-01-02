defmodule PickingUp.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()
  end

  def main() do
    n = read_single()

    xys = read_multi_array()

    c =
      combination(xys , 2)
      |> count([])
      |> Enum.frequencies()
      |> Map.values()
      |> (fn
          [] -> 0
          values -> values |> Enum.max()
        end).()


    n - c
    |> IO.puts()
  end

  def count([], acc), do: acc
  def count([[[x1, y1], [x2, y2]] | tail], acc) do
    acc = [{x2 - x1, y2 - y1}, {x1 - x2, y1 - y2} | acc]
    count(tail, acc)
  end

  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end

end
