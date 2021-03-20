defmodule Abc195.C.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    #
    n = read_single()

    solve(n, 0, 0)
    |> IO.puts()
  end

  def solve(n, k, acc) do
    kk = k + 1
    a = floor(:math.pow(1000, kk))
    nn = n - a

    if nn < 0 do
      acc
    else
      acc = acc + (min(floor(:math.pow(1000, kk + 1)) - a, nn + 1) * kk)
      solve(n, k + 1, acc)
    end
  end
end
