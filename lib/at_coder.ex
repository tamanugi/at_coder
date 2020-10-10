defmodule Helper do
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
