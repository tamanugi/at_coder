defmodule FactorsOfFactorial.Main do
  @mod 1000_000_000 + 7

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    if n > 1 do
      primes = sieve(n)

      2..n
      |> Enum.reduce(%{}, fn i, acc ->
        count(i, primes, acc)
      end)
      |> Map.values()
      |> Enum.map(fn i -> i + 1 end)
      |> Enum.reduce(fn i, acc -> rem(i * acc, @mod) end)
      |> IO.puts()
    else
      IO.puts(1)
    end

  end

  # 指定された数字を素因数分解して出現した素数の数を記録する
  def count(_, _, acc \\ %{})
  def count(1, _, acc), do: acc
  def count(_i, [], acc), do: acc
  def count(i, [h | t], acc) do
    {n, count} = d(i, h)
    acc = Map.update(acc, h, count, fn c -> c + count end)
    count(n, t, acc)
  end

  # 割り続けられるまで割る
  def d(n, p, acc \\ 0)
  def d(1, _p, acc), do: {1, acc}
  def d(n, p, acc) do
    if rem(n, p) == 0 do
      d(div(n, p), p, acc + 1)
    else
      {n, acc}
    end
  end

  def sieve (n) do
    Stream.iterate(2, &(&1+1))
    |> Stream.unfold(fn (s) ->
      p    = s |> Enum.at(0)
      next = s |> Stream.filter(fn(x) -> rem(x, p) != 0 end)
      {p, next}
    end)
    |> Stream.take_while(&(&1 <= n))
    |> Enum.to_list()
  end

end
