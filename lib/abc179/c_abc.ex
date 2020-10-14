defmodule Abc.Main do
  def main() do
    n = read_single()

    solve(n)
    |> IO.puts()
  end

  def solve(n) do
    solve(n, 1, div(n, 2), 0)
  end

  def solve(n, i, max, acc) when i <= max do
    acc = acc + div(n - 1, i)
    solve(n, i + 1, max, acc)
  end
  def solve(n, i, _, acc), do: acc + (n - i)

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
    n = 1000000
    # steps = (for _ <- 1..n, do: (1..300 |> Enum.random()) * 10 |> Integer.to_string) |> read_map(0, %{})
    {time, result} = :timer.tc(Abc.Main, :solve, [n])
    IO.inspect(result)
    IO.inspect(time)
  end

end
