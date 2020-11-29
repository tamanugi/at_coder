defmodule HandStand2.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    acc = 1..n+1 |> solve(%{})

    (for i <- 1..9, j <- 1..9, do: {i, j})
    |> Enum.map(fn {i, j} -> Map.get(acc, {i, j}, 0) * Map.get(acc, {j, i}, 0) end)
    |> Enum.sum()
    |> IO.puts()
  end

  def solve(n..n, acc), do: acc
  def solve(i..n, acc) do
    s = Integer.digits(i)

    h = List.first(s)
    t = List.last(s)

    acc = if t > 0, do: Map.update(acc, {h, t}, 1, fn c -> c + 1 end), else: acc
    solve(i+1..n, acc)
  end

end
