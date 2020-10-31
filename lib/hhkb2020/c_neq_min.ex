defmodule NeqMin.Main do

  def main() do
    _ = read_single()
    inputs = read_array()

    solve(inputs, 0, %{})
  end

  def solve(_, _, _, o \\ [])
  def solve([], _, _, outputs), do: outputs |> Enum.reverse() |> Enum.join("\n") |> IO.puts()
  def solve([h | t], at, map, outputs) do
    map = Map.put(map, h, true)
    at = output(map, at)
    solve(t, at, map, [at | outputs])
  end

  def output(map, at) do
    if map[at], do: output(map, at + 1), else: at
  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_map() do
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> read_map(0, %{})
  end

  def read_map([], _, acc), do: acc
  def read_map([h|t], i, acc) do
    acc = Map.put(acc, i, String.to_integer(h))
    read_map(t, i + 1, acc)
  end

  def test() do
    n = 20_000
    inputs = (for _ <- 1..n, do: (:rand.uniform() * 10000) |> floor() )

    inputs |> Enum.sort() |> IO.inspect()
    {time, _} = :timer.tc(NeqMin.Main, :solve, [inputs, 0, %{}])
    IO.inspect(time)
  end


end
