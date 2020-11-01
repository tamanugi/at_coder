defmodule EnoughArray.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, k] = read_array()

    as = read_array()
    sum = Enum.sum(as)

    cond do
      sum > k -> solve(as, sum, k, 0)
      sum == k -> 1
      sum < k -> 0
    end
    |> IO.puts()
  end

  def solve([], _sum, _k, acc), do: acc
  def solve(_, sum, k, acc) when sum < k, do: acc
  def solve([h | t] = as, sum, k, acc) do
    acc = acc + process(Enum.reverse(as), sum, k, 0)
    sum = sum - h
    solve(t, sum, k, acc)
  end

  def process([], _sum, _k, acc), do: acc
  def process(_, sum, k, acc) when sum < k, do: acc
  def process([h | t], sum, k, acc) do
    acc = if sum >= k, do: acc + 1, else: acc
    sum = sum - h
    process(t, sum, k, acc)
  end

  def test() do
    n = 100000
    as = for _ <- 1..n, do: floor(:rand.uniform() * n)
    k = 1000
    :timer.tc(&solve/4, [as, Enum.sum(as), k, 0])
    |> IO.inspect()
  end

end
