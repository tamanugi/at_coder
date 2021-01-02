defmodule Abc185.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def main() do
    [n, _, t] = read_array()

    abs = read_multi_array()

    solve(abs, n, n, 0, t)
    |> IO.puts()
  end

  def solve([], batterry, _, c, time) do
    if batterry - (time - c) > 0, do: "Yes", else: "No"
  end
  def solve([[a, b] | t], battery, mx_b, c, time) do
    # カフェについたときの容量
    battery = battery - (a - c)

    unless battery <= 0 do
      # カフェでの充電　
      battery = min(battery + (b - a), mx_b)
      solve(t, battery, mx_b, b, time)
    else
      "No"
    end
  end
end
