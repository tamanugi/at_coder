defmodule Arc110.A.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    solve(n)
    |> IO.puts()
  end

  def solve(n) do
    # 2..10を
    # 素因数分解
    # 30までの素数

    (for i <- 2..n, do: i)
    |> make(1)
    |> Kernel.+(1)
  end

  def make([], acc), do: acc
  def make([h | t], acc) do
    acc = acc * h

    t = t |> Enum.map(fn i ->
      if rem(i, h) == 0 do
        div(i, h)
      else
        i
      end
    end)
    |> Enum.filter(fn i -> i > 0 end)

    make(t, acc)
  end

  def check() do
    2..30
    |> Enum.map(fn i ->
      s = solve(i)
      IO.inspect({i, s})
      2..i
      |> Enum.map(fn i -> rem(s, i) end)
      |> Enum.uniq()
    end)
    |> IO.inspect()
  end

  def divis(n, primes, acc) do
    case primes |> Enum.find_value(n, fn i -> rem(n, i) == 0 end) do
      ^n -> [n | acc]
      a ->
        divis(div(n, a), primes, [a | acc])
    end
  end

  def primes() do
    Stream.iterate(3, &(&1+2))
    |> Stream.take_while(&(&1 < 30))
    |> Stream.unfold(fn (s) ->
      p    = s |> Enum.at(0)
      next = s |> Stream.filter(fn(x) -> rem(x, p) != 0 end)
      {p, next}
    end)
    |> Enum.to_list()
  end
end
