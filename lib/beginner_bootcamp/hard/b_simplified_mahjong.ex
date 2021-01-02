defmodule SimplifiedMahjong.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn i -> String.to_integer(i) end)
    |> Enum.to_list()
  end

  def main() do
    _ = read_single()
    as = read_multi_array()

    solve(as, 0, 0)
    |> IO.puts()
  end

  def solve([], _, acc), do: acc
  def solve([h | t], pre, acc) do
    res = div(h + pre, 2)
    pre =
      case h do
        0 -> 0
        h -> rem(h + pre, 2)
      end
    solve(t, pre, acc + res)
  end
end
