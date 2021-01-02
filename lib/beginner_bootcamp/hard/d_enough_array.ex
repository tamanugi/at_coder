defmodule EnoughArray.Main do
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

  def main() do
    [n, k] = read_array()

    as = read_map()

    solve(as, n, k)
    |> IO.puts()
  end

  def solve(as, n, k) do
    solve({0, 0, 0}, as, n, k, 0)
  end

  def solve({l, _, _}, _, n, _, acc) when l == n, do: acc
  def solve({l, r, sum}, as, n, k, acc) do
    h = as[l]
    {r, sum} = find_r({r, sum}, as, n, k)
    acc =  if sum >= k, do: acc + n - r + 1, else: acc
    sum = sum - h
    solve({l + 1, r, sum}, as, n, k, acc)
  end

  def find_r({r, sum}, _, n, _) when r == n, do: {n, sum}
  def find_r({r, sum}, as, n, k) do
    if sum >= k do
      {r, sum}
    else
      sum = sum + as[r]
      find_r({r + 1, sum}, as, n, k)
    end
  end

  def test() do
    n = 100000
    as = for _ <- 1..n, do: floor(:rand.uniform() * n)
    k = 100000 - 10
    :timer.tc(&solve/3, [as, k, n])
    |> IO.inspect()
  end

end
