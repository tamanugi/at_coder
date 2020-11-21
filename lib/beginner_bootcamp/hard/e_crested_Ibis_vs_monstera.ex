defmodule CrestedIbisMonster.Main do

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
    abs = read_multi_array()

    # MP効率がいい魔法
    altema = abs |> Enum.max_by(fn [a, b] -> a/b end)

    IO.inspect(altema)

  end

end
