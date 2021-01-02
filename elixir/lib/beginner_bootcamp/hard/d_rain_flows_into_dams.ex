defmodule RainFlowsIntoDams.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _n = read_single()
    as = read_array() |> Enum.with_index()
    s =
      as
      # 偶奇それぞれの和を計算する
      |> Enum.reduce({0, 0}, fn {v, i}, {s1, s2} ->
          if rem(i, 2) == 0 do
            {s1 + v, s2}
          else
            {s1, s2 + v}
          end
      end)

    solve(as, s)
    |> Enum.join(" ")
    |> IO.puts()
  end

  def solve(_, _, acc \\ [])
  def solve([], _, acc), do: acc |> Enum.reverse()
  def solve([{h, i} | t], {s1, s2}, acc) do
    {a, s1, s2} =
      if rem(i, 2) == 0 do
        {s1 - s2, s1 - h, s2 + h}
      else
        {s2 - s1, s1 + h, s2 - h}
      end

    solve(t, {s1, s2}, [a | acc])
  end

end
