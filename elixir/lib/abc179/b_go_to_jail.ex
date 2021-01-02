defmodule GoToJail.Main do
  def main() do
    _ = read_single()
    read_multi_array()
    |> solve(0)
    |> IO.puts()
  end

  def solve(_, 3), do: "Yes"
  def solve([], _) , do: "No"
  def solve([[d1, d2] | t], acc) when d1 == d2, do: solve(t, acc + 1)
  def solve([_ | t], _), do: solve(t, 0)

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

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def test() do
    n = 10
    steps = (for _ <- 1..n, do: [:rand.uniform * 2 |> floor, :rand.uniform * 3 |> floor])
    IO.inspect(steps)
    {time, result} = :timer.tc(GoToJail.Main, :solve, [steps, 0])
    IO.inspect(result)
    IO.inspect(time)
  end

end
