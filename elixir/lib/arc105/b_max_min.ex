defmodule MaxMin.Main do

  def main() do
    _ = read_single()
    nums =read_array()

    solve(nums)
  end

  def solve(nums) do
    min = Enum.min(nums)
    nums = nums
    |> Enum.map(fn i -> rem(i, min) end)
    |> Enum.uniq()
    |> Enum.filter(fn i -> i > 0 end)

    case nums do
      [] -> IO.puts(min)
      nums -> solve(nums)
    end
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
    n = 1000
    steps = (for _ <- 1..n, do: (:rand.uniform() * 50_000 |> floor ) * 82 )
    {time, _} = :timer.tc(MaxMin.Main, :solve, [steps])
    IO.inspect(time)
  end



end
