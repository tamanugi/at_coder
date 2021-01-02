defmodule InsertingX.Main do

  def main() do
    s = IO.read(:line) |> String.trim() |> String.split("") |> Enum.filter(&(&1 != ""))

    solve(s, Enum.reverse(s), 0)
    |> div(2)
    |> IO.puts()
  end

  def solve([], [], acc), do: acc
  def solve(["x" | t], [], acc), do: solve(t, [], acc + 1)
  def solve([], ["x" | t], acc), do: solve([], t, acc + 1)
  def solve(_, [], _), do: -2
  def solve([], _, _), do: -2
  def solve([h1 | t1], [h2 | t2], acc) do
    cond do
      h1 == h2 -> solve(t1, t2, acc)
      h1 == "x" -> solve(t1, [h2 | t2], acc + 1)
      h2 == "x" -> solve([h1 | t1], t2, acc + 1)
      true -> -2
    end
  end
end
