defmodule BetweenAandB.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [a, b, x] = read_array()

    div_if_zero(b, x) - div_if_zero(a - 1, x)
    |> IO.puts()
  end

  def div_if_zero(a, _) when a < 0, do: -1
  def div_if_zero(a, b), do: div(a, b)
end
