defmodule Wall.Main do

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

  def main() do
    [h, w] = read_array()

    mp =
      (for i <- 0..9, do: {i, read_map()})
      |> Map.new()

    minmap = (for i <- 0..9, do: {i, mp[i][1]}) |> Map.new() |> IO.inspect()

    walls =
      IO.read(:all)
      |> String.split("\n")
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(fn s -> s |> String.split(" ") end)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> IO.inspect()

  end

  def move([h | t], mp, tmp, acc) do
    to1 = mp[h][1]

    candi = mp[h] |> Map.to_list() |> Enum.filter(fn {i, v} -> v > 0 and v < to1 end)

    # move(t ++ candi, mp, tmp, acc)
  end

end
