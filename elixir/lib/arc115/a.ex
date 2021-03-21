defmodule Arc115.A.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
  end

  def main() do
    [n, m] = read_array()

    s = read_multi()

    solve(s, 0)
    |> IO.puts()
  end

  def solve([], acc), do: acc
  def solve([h | t], acc) do

    h_codepoints = String.codepoints(h)

    acc =
      t
      |> Enum.reduce(0, fn s, count ->
        Enum.zip(h_codepoints, String.codepoints(s))
        |> Enum.count(fn {a, b} -> a != b end)
        |> rem(2)
        |> (fn
          0 -> count
          1 -> count + 1
        end).()
      end)
      |> Kernel.+(acc)

      solve(t, acc)
  end

  def test() do
    (for i <- 1..100_000, do: "111000111")
    |> solve(0)
    |> IO.puts()
  end

end
