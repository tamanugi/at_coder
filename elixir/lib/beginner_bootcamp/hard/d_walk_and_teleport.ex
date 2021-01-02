defmodule WalkAndTeleport.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, a, b] = read_array()
    [h | t] = read_array()

    solve(t, a, b, h, 0)
    |> IO.puts()
  end

  def solve([], _, _, _, acc), do: acc
  def solve([h | t], a, b, pre, acc) do
    acc = acc + min((h - pre) * a, b)
    solve(t, a, b, h, acc)
  end

end
