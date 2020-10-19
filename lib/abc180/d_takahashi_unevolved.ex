defmodule TakahashiUnevolved.Main do
  def main() do
    [x, y, a, b] = read_array()

    solve(x, y, a, b, 0)
  end

  def solve(x, y, _, _, exp) when x >= y, do: exp |> IO.puts()
  def solve(x, y, a, b, exp) do
    aa = x * a
    bb = x + b

    cond do
      aa >= y and bb >= y -> exp |> IO.puts()
      aa <= bb and aa < y -> solve(aa, y, a, b, exp + 1)
      aa > bb ->
        (exp + div((y - x - 1), b))
        |> IO.puts
    end

  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

end
