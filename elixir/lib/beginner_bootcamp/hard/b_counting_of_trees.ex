defmodule CountingOfTrees.Main do

  @mod 998244353

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _n = read_single()
    ds = read_array()

    [h | _] = ds

    if h == 0 do
      dist = ds |> Enum.frequencies()
      {max, _} = dist |> Map.to_list() |> Enum.max_by(fn {d, _} -> d end)
      solve(dist, max)
    else
      0
    end
    |> IO.puts()
  end

  def solve(%{0 => c} = _dist, _) when c > 1, do: 0
  def solve(dist, max), do: solve(dist, max, 1)

  def solve(_dist, 0, acc), do: acc
  def solve(_dist, _, 0), do: 0
  def solve(dist, n, acc) do
    pre = Map.get(dist, n - 1, 0)

    p = Map.get(dist, n, 0)
    p = pow(pre, p) |> rem(@mod)
    acc = acc * p
    acc = rem(acc, @mod)

    solve(dist, n - 1, acc)
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
