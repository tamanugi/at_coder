defmodule AtCoder176A do
  def main() do
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve()
    |> IO.puts()
  end

  def solve([n, x, t]) do
    case {div(n, x), rem(n, x)} do
      {c, 0} -> c * t
      {c, _} -> (c + 1) * t
    end
  end
end
