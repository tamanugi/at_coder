defmodule Wandering.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()
    as = read_array()

    # 各iでの座標移動値
    # 各iでの座標の最大値
    {pmap, qmap} = p(as)


    {_, r} =
      1..n
      |> Enum.reduce({0, 0}, fn i, {x, r} ->
        r = max(r, x + qmap[i])
        x = x + pmap[i]
        {x, r}
      end)

    r
    |> IO.puts()

  end

  def p([h | t]), do: p(t, [h], [h])

  def p([], acc, acc2) do
    {
     acc |> Enum.reverse() |> Enum.with_index(1) |> Enum.map(fn {v, i} -> {i, v} end) |> Map.new(),
     acc2 |> Enum.reverse() |> Enum.with_index(1) |> Enum.map(fn {v, i} -> {i, v} end) |> Map.new()
    }
  end
  def p([h | t], [p | _] = acc, [p2 | _] = acc2) do
    p(t, [p + h | acc], [ max(p + h, p2) | acc2])
  end

end
