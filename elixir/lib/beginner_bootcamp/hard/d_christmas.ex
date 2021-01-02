defmodule Christmas.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, m] = read_array()

    solve(n, m)
    |> IO.puts()
  end

  def solve(0, _), do: 1
  def solve(lv, x) do
    {a, b} = burger_size(lv - 1)

    cond do
      x == 1 -> 0
      x <= a + 1  ->
        solve(lv - 1, x - 1)
      x == a + 2 ->
        b + 1
      true ->
        b + 1 + solve(lv - 1, x - a - 2)
    end
  end

  def burger_size(n), do: {pow(2, n + 2) - 3, pow(2, n + 1) - 1}

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
