defmodule EnoughArray.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, k] = read_array()

    as = read_array()

    solve(as, k, n)
    |> IO.puts()
  end

  def solve(as, k, n) do
    as
    |> Enum.reduce([0], fn a, [h | _] = acc ->
      [a + h | acc]
    end)
    |> Enum.reverse()
    |> Enum.with_index()
    |> solve(k, n, 0)
  end

  def solve([], _k, _n, acc), do: acc
  def solve([{h, _} | t] = as, k, n, acc) do
    IO.inspect(h)
    r =
      t
      |> Enum.reduce_while(n, fn {sum, i}, _ ->
        if sum - h > k do
          {:halt, i}
        else
          {:cont, n}
        end
      end)

    if r < n do
      solve(t, k, n, acc + (n - r  + 1))
    else
      solve(t, k, n, acc)
    end
  end

  def process([{h, i} | _], a, k) when (h - a) >= k, do: i
  def process([_ | t], a, k), do: process(t, a, k)
  def process([], _, _), do: nil

  def test() do
    n = 100000
    as = for _ <- 1..n, do: floor(:rand.uniform() * n)
    k = 100000 - 10
    :timer.tc(&solve/3, [as, k, n])
    |> IO.inspect()
  end

end
