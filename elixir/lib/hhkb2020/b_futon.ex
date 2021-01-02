defmodule Futon.Main do

  def main() do
    [h, w] = read_array()

    floor =
      1..h
      |> Enum.flat_map(fn _ ->
        IO.read(:line) |> str_to_floor()
      end)

    solve(h, w, floor)
    |> IO.puts()
  end

  def solve(h, w, floor) do
    can_futon = (for i <- 0..(h - 1), j <- 0..(w - 1), Enum.at(floor, i * w + j) == ".", do: {i, j})
    process(can_futon, 0)
  end

  def process([], acc), do: acc
  def process([{i, j} | tail], acc) do
    acc = acc + if Enum.member?( tail, {i, j + 1}), do: 1, else: 0
    acc = acc + if Enum.member?( tail, {i + 1, j}), do: 1, else: 0
    process(tail, acc)
  end

  def str_to_floor(str) do
    str
    |> String.trim()
    |> String.split("")
    |> Enum.filter(&(String.length(&1) > 0))
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
    h = 100
    w = 100
    floor = (for _ <- 1..100, _ <- 1..100, do: ".")
    {time, _} = :timer.tc(Futon.Main, :solve, [h, w, floor])
    IO.inspect(time)
  end

end
