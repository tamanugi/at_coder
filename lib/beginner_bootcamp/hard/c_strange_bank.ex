defmodule StrangeBank.Main do
  @inf 1000_000_000

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    # n 以下の金額を用意する
    sixs = moneys(6, n)
    nines = moneys(9, n)

    moneys = [1 | sixs ++ nines]

    dp =
      2..n
      |> Enum.map(fn i -> {i, @inf} end)
      |> Map.new()
      |> Map.put(1, 1)

    # 一回で払える金額
    dp = moneys |> Enum.reduce(dp, fn i, dp -> Map.put(dp, i, 1) end)

    dp(1..n, moneys, dp)
    |> Map.get(n)
    |> IO.puts()
  end

  def dp(n..n, _, acc), do: acc
  def dp(i..n, moneys, acc) do
    c = Map.get(acc, i)

    acc =
      moneys
      |> Enum.reduce(acc, fn m, acc ->
        unless i + m > n do
          Map.update!(acc, i + m, fn v -> min(c + 1, v) end)
        else
          acc
        end
      end)

    dp(i+1..n, moneys, acc)
  end

  def moneys(m, n) do
    Stream.iterate(1, &(&1 + 1))
    |> Stream.map(fn i -> pow(m, i) end)
    |> Stream.take_while(fn i -> i <= n end)
    |> Enum.to_list()
  end

  def pow(_, 0), do: 1
  def pow(m, 2), do: m * m
  def pow(m, n) do
    case div_and_rem(n, 2) do
      {a, 0} -> pow(m, a) |> pow(2)
      {a, 1} -> (pow(m, a) |> pow(2)) * m
    end
  end
  def div_and_rem(m, n) do
    {div(m, n), rem(m, n)}
  end

end
