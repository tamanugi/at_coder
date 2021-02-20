defmodule Abc192.D.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end
  def read_s() do
    IO.read(:line) |> String.trim()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    x = read_s()
    m = read_single()

    arr = x |> String.codepoints() |> Enum.map(&String.to_integer/1)

    d = arr |> Enum.max()

    solve(arr, d + 1, m, 0)
    |> IO.puts()
  end

  def solve(x, d, m, acc) do
    if Integer.undigits(x, d) > m do
      acc
    else
      solve(x, d + 1, m, acc + 1)
    end
  end

end
