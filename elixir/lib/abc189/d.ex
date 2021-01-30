defmodule Abc189.D.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
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

  def main() do
    _ = read_single()

    read_multi_array()
    |> Enum.reverse()
    |> solve(1)
    |> IO.puts()
  end

  def solve([], acc), do: acc
  def solve(["OR" | t], acc), do: solve(t, acc + pow(2, Enum.count(t) + 1))
  def solve(["AND"| t], acc), do: solve(t, acc)

  def test() do
    n = 6
    0..(pow(2, n) - 1)
    |> Enum.map(fn i ->
      s = Integer.digits(i, 2)
      if Enum.count(s) < n do
        {a, _} = Enum.split([0, 0, 0, 0, 0, 0], n - Enum.count(s))
        a ++ s
      else
        s
      end
    end)
    |> Enum.map(fn [a, b, c, d, e, f] ->
      Bitwise.bor(a, b)
      |> Bitwise.bor(c)
      |> Bitwise.band(d)
      |> Bitwise.bor(e)
      |> Bitwise.bor(f)
    end)
    |> Enum.filter(fn i -> i == 1 end)
    |> Enum.count()
    |> IO.inspect()
  end
end
