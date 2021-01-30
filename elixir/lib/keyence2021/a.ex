defmodule Keyence2021.A.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    a = read_array()
    b = read_array()

    solve(a, b, {1, 1, 1}, [])
  end

  def solve([], [], _, acc) do
    acc
    |> Enum.reverse()
    |> Enum.join("\n")
    |> IO.puts()
  end
  def solve([a | at], [b | bt], {ax, bx, tmp}, acc) do
    c = Enum.max([a * b, ax * b, tmp])
    tmp = max(tmp, c)
    ax = max(a, ax)
    bx = max(b, bx)
    solve(at, bt, {ax, bx, tmp}, [c | acc])
  end
end
