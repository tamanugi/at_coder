defmodule  ZeroSumRanges.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    as = read_array()

    prepare(as)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.filter(fn i -> i > 1 end)
    |> Enum.map(fn i -> div(i * (i - 1), 2) end)
    |> Enum.sum()
    |> IO.puts()
  end

  def prepare([h | t]), do: prepare(t, [h, 0])
  def prepare([], acc), do: acc |> Enum.reverse()
  def prepare([h | t], [pre | _] = acc) do
    prepare(t, [pre + h | acc])
  end
end
