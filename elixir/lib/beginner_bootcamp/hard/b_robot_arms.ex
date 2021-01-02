defmodule RobotArms.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    # 始点と終点に変換する
    |> Stream.map(fn [x, l] -> {x-l, x+l} end)
    |> Enum.to_list()
  end

  def main() do
    _ = read_single()

    xys =
      read_multi_array()
      |> Enum.sort_by(fn {_x, y} -> y end)

    solve(xys)
    |> IO.puts()
  end

  def solve([{_, y} | t]) do
    solve(t, y, 1)
  end
  def solve([], _, acc), do: acc
  def solve([{x, y} | t], pre, acc) do
    if x >= pre do
      # かぶってない
      solve(t, y, acc + 1)
    else
      # かぶり
      solve(t, pre, acc)
    end
  end

end
