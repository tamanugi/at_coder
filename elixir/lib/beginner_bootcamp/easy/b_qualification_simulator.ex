defmodule QualificationSimulator.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, a, b] = read_array()
    players = IO.read(:line) |> String.trim() |> String.split("") |> Enum.filter(&(String.length(&1) > 0 ))

    solve(players, a, b, 0, 0, [])
    |> Enum.reverse()
    |> Enum.join("\n")
    |> IO.puts
  end

  def solve([], _, _, _, _, acc), do: acc
  def solve([_ | t], a, b, c1, c2, acc) when a + b <= c1, do: solve(t, a, b, c1, c2, ["No" | acc])
  def solve(["a" | t], a, b, c1, c2, acc) do
    acc = ["Yes" | acc]
    solve(t, a, b, c1 + 1, c2, acc)
  end

  def solve(["b" | t], a, b, c1, c2, acc) do
    if c2 < b do
      acc = ["Yes" | acc]
      solve(t, a, b, c1 + 1, c2 + 1, acc)
    else
      acc = ["No" | acc]
      solve(t, a, b, c1, c2, acc)
    end
  end

  def solve(["c" | t], a, b, c1, c2, acc) do
    acc = ["No"| acc]
    solve(t, a, b, c1, c2, acc)
  end
end
