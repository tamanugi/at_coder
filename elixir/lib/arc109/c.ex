defmodule Arc109.C.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, k] = read_array()
    hands = IO.read(:line) |> String.trim() |> String.codepoints()

    solve(1..k, 2 * n, hands ++ hands)
    |> Enum.at(0)
    |> IO.puts()
  end

  def solve(i..k, _, r) when i > k, do: r
  def solve(i..k, n, hands) do

    r =
    Stream.iterate(0, &(&1 + 2))
    |> Stream.take_while(&(&1 < n))
    |> Enum.to_list()
    |> Enum.reduce([], fn i, acc ->
      a = Enum.at(hands, i)
      b = Enum.at(hands, i + 1)

      [rps(a, b) | acc]
    end)
    |> Enum.reverse()

    solve(i+1..k, n, r ++ r)
  end

  def rps(a, b) when a == b, do: a
  def rps("R", b), do: if b == "S", do: "R", else: b
  def rps("P", b), do: if b == "R", do: "P", else: b
  def rps("S", b), do: if b == "P", do: "S", else: b
end
