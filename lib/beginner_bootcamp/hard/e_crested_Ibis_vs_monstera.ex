defmodule CrestedIbisMonster.Main do

  @inf 1000_000_000

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()
  end

  def main() do
    [h, _] = read_array()
    abs = read_multi_array() |> Enum.sort_by(fn [_, b] -> b end)

    # 一番消費MPが少ないものよりHPが少ない場合は明らかにそれを使えばok
    [[a, b] | _] = abs
    if h <= a do
      b
    else
      dp(0..h, abs, %{0 => 0})
      |> Map.get(h)
    end
    |> IO.puts()
  end

  def dp(h..h, _, dp), do: dp
  def dp(i..h, abs, dp) do

    dp =
      abs
      |> Enum.reduce(dp, fn [a, b], dp ->
        next_index = min(i + a, h)
        v = min(Map.get(dp, next_index, @inf), Map.get(dp, i, @inf) + b)
        Map.put(dp, next_index, v)
      end)

    dp(i+1..h, abs, dp)
  end

end
