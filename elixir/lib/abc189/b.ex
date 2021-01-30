defmodule Abc189.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()
  end

  def main() do
    [_, x] = read_array()


    read_multi_array()
    |> Enum.with_index(1)
    |> solve(x * 100)
    |> IO.puts()
  end

  def solve([], _acc), do: -1
  def solve([{[v, p], i} | tail], acc) do
    case acc - (v * p) do
      xx when xx < 0 -> i
      acc -> solve(tail, acc)
    end
  end
end
