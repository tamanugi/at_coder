defmodule Id.Main do

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
    [_, _] = read_array()

    pys = read_multi_array()

    map =
      pys
      |> Enum.sort_by(fn [_, y] -> y end, :desc)
      |> Enum.reduce(%{}, fn [p, y], acc ->
        Map.update(acc, p, [y], fn v -> [y | v] end)
      end)

    solve(pys, map, [])
    |> IO.puts()
  end

  def solve([], _, acc), do: acc |> Enum.reverse() |> Enum.join("\n")
  def solve([[p, y] | t], map, acc) do
    i =
      Map.get(map, p, [y])
      |> Enum.find_index(fn v -> v == y end)
      |> Kernel.+(1)

    # {_, s1} = String.split_at("000000#{p}", -6)
    s1 = String.pad_leading("#{p}", 6, "0")
    s2 = String.pad_leading("#{i}", 6, "0")
    solve(t, map, [s1 <> s2 | acc])
  end

end
