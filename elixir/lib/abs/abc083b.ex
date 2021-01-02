defmodule Abc083B.Main do

  def main() do
    [n, a, b] = IO.read(:line) |> String.split(" ") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)

    solve(n, a, b)
    |> IO.puts()
  end

  def solve(n, a, b) do
    1..n
    |> Enum.filter(fn i ->
      # 各桁の和を求める :thinking:
      s =  Integer.digits(i) |> Enum.sum()
      s >= a and s <= b
    end)
    |> Enum.sum()
  end

end
