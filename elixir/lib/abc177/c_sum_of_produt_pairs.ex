defmodule SumOfProductPairs.Main do
  @mod 1000_000_007

  def main() do
    _ = read_single()
    as = read_array()

    solve(as)
  end

  def solve(as) do
    sum = Enum.sum(as)
    solve(as, sum, 0)
  end

  def solve([_ | []], _, acc), do: acc |> rem(@mod) |> IO.puts()
  def solve([h | t], sum, acc) do
    sum = sum - h
    acc = acc + rem(sum * h, @mod)
    solve(t, sum, acc)
  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def test() do
    n = 200000
    steps = (for _ <- 1..n, do: (:rand.uniform * 1000_000_000) |> floor)
    :timer.tc(SumOfProductPairs.Main, :solve, [steps])
    |> IO.inspect()
  end

end
