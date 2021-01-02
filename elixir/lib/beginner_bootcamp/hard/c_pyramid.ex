defmodule Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()
  end

  def main() do
    _ = read_single()
    xys = read_multi_array() |> Enum.sort_by(fn [_, _, h] -> h end, :desc)

    (for i <- 0..100, j <- 0..100, do: {i, j})
    |> solve(xys)
    |> Enum.join(" ")
    |> IO.puts()
  end

  def solve([{i, j} | t], xys) do

    h =
      xys
      |> Enum.reduce_while(nil, fn [x, y, h],pre ->
        hh = h + abs(x - i) + abs(y - j)
        cond do
          pre == nil -> {:cont, hh}
          pre == hh -> {:cont, hh}
          h == 0 and hh >= pre ->
            {:cont, pre}
          true ->
            {:halt, :ng}
        end
      end)

    case h do
      :ng -> solve(t, xys)
      _ -> [i, j, h]
    end
  end

end
