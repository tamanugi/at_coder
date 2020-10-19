defmodule CreamPuff.Main do
  def main() do
    read_single()
    |> solve()
  end

  def solve(n), do: solve(n, 2, :math.sqrt(n) |> floor, [1, n])

  def solve(_, i, sqrt, acc) when i > sqrt, do: acc |> Enum.uniq |> Enum.sort() |> Enum.join("\n") |> IO.puts()
  def solve(n, i, sqrt, acc) do
    case div_and_rem(n, i) do
      {d, 0} -> solve(n, i + 1, sqrt, [d, i | acc])
      _ -> solve(n, i + 1, sqrt, acc)
    end
  end

  def div_and_rem(n, i), do: {div(n, i), rem(n, i)}

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

end
