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
    [_n, m] = read_array()

    s = read_multi()

    solve(s, m)
    |> IO.puts()
  end

  def solve(s, m) do

    zeros = for _ <- 1..m, do: "0"

    s
    |> Enum.map(fn s ->
      String.codepoints(s)
      |> Enum.zip(zeros)
      |> Enum.count(fn {a, b} -> a != b end)
    end)
    |> Enum.reduce({0, 0}, fn i, {a, b} ->
      case rem(i, 2) do
        0 -> {a + 1, b}
        1 -> {a, b + 1}
      end
    end)
    |> (fn {a, b} -> a * b end).()
  end

  def test() do
    (for i <- 1..100_000, do: "111000111")
    |> solve(0)
    |> IO.puts()
  end

end
