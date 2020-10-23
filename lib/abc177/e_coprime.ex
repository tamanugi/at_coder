defmodule Coprime.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def test() do
    n = 1000_000
    nums = for _ <- 1..n, do: ((:rand.uniform() * n + 5)|> floor())
    :timer.tc(Coprime.Main, :solve, [nums])
    |> IO.inspect()
  end

  def main() do
    _ = read_single()
    nums =read_array()
    # solve(nums)

    (for i <- 2..100, do: i)
    |> IO.inspect()
  end

  def sieve([], primes), do: Enum.reverse(primes)
  def sieve([h | t], primes) do
    sieve(t, [h | primes])
  end

  def solve(nums) do
    nums = Enum.sort(nums)
    case solve1(nums) do
      :coprime -> solve2(nums)
      :not_coprime -> IO.puts("not coprime")
    end
  end

  def solve1(nums) do
    min = Enum.min(nums)
    nums = nums
    |> Enum.map(fn i -> rem(i, min) end)
    |> Enum.uniq()
    |> Enum.filter(fn i -> i > 0 end)

    case nums do
      [] ->
        case min do
          1 -> :coprime
          _ -> :not_coprime
        end
      nums -> solve1(nums)
    end
  end

  def solve2([]), do: IO.puts("pairwise coprime")
  def solve2([h | t]) do
    res = t
    |> Enum.reduce_while(:ok, fn i, _ ->
      case Integer.gcd(i, h) do
        1 -> {:cont, :ok}
        _ -> {:halt, :ng}
      end
    end)

    case res do
      :ng -> IO.puts("setwise coprime")
      :ok -> solve2(t)
    end
  end

end
