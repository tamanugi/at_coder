defmodule Abc188.D.Main do
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
    [_, c] = read_array()

    read_multi_array()
    |> imos(%{})
    |> Map.to_list()
    |> Enum.sort_by(fn {i, _v} -> i end)
    |> IO.inspect()
    # |> Enum.reduce({nil, 0}, fn {date, cost}, {pre, acc} ->

    # end)
    # |> IO.inspect()
  end

  def imos([], acc), do: acc
  def imos([[a, b, c] | t], acc) do
    span = b - a + 1
    cost = c * span
    acc = Map.update(acc, a, cost, fn cur -> cur + cost end)
    acc = Map.update(acc, b + 1, 0 - cost, fn cur -> cur - cost end)

    imos(t, acc)
  end
end
