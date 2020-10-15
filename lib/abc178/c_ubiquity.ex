defmodule Ubiquity.Main do
  @mod 1000_000_007

  def main() do
    read_single()
    |> solve()
  end

  def solve(n) do
    (2 * @mod + pow(10, n) - (2 * pow(9, n)) + pow(8, n))
    |> rem(@mod)
    |> IO.puts
  end

  def pow(_, 0), do: 1
  def pow(m, 2), do: rem(m * m, @mod)
  def pow(m, n) do
    case div_and_rem(n, 2) do
      {a, 0} -> pow(m, a) |> pow(2)
      {a, 1} -> (pow(m, a) |> pow(2)) * m
    end
    |> rem(@mod)
  end

  def div_and_rem(m, n) do
    {div(m, n), rem(m, n)}
  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def test() do
    n = 869121
    {time, r} = :timer.tc(Ubiquity.Main, :solve, [n])
    IO.inspect(r)
    IO.inspect(time)
  end
end
