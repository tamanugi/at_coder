defmodule FortuneCookie.Main do

  def main() do
    read_map()
    |> solve()
  end

  def solve(cookies) do
    (for i <- 0..3, j <- 0..4, i != j, do: {i, j})
    |> Enum.reduce_while("No", fn {i, j}, _ ->
      eat = Map.get(cookies, i, 0) + Map.get(cookies, j, 0)
      rest = Map.drop(cookies, [i, j]) |> Map.values() |> Enum.sum()

      if eat == rest do
        {:halt, "Yes"}
      else
        {:cont, "No"}
      end
    end)
    |> IO.puts()
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
    n = 100000
    steps = (for _ <- 1..n, do: (1..300 |> Enum.random()) * 10 |> Integer.to_string) |> read_map(0, %{})
    {time, _} = :timer.tc(Main, :solve, [n, 100, steps])
    IO.inspect(time)
  end

end
