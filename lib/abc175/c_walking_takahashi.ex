defmodule WalkingTakahashi.Main do

  require Integer

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [x, k, d] = read_array()

    solve(x, k, d)
    |> abs()
    |> IO.inspect()
  end

  def solve(x, 0, _), do: x
  def solve(x, k, d) when abs(x) <= d and k > 0 do
    sign = if x > 0, do: 1, else: -1
    if Integer.is_even(k), do: x, else: x - sign * d
  end
  def solve(x, k, d) do
    sign = if x > 0, do: 1, else: -1
    n = min(k, abs(div(x, d)))
    x = x - sign * d * n
    solve(x, k - n, d)
  end

end
