defmodule FlippingSigns.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()

    read_array()
    |> solve(nil, 0, 0)
  end


  def solve([], min, minus, sum) do
    if rem(minus, 2) == 0 do
      sum
    else
      sum - (2 * min)
    end
    |> IO.puts()
  end
  def solve([h | t], min, minus, sum) do

    min = min(abs(h), min)
    minus = if h < 0, do: minus + 1, else: minus
    sum = sum + abs(h)

    solve(t, min, minus, sum)
  end

end
