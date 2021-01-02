defmodule Abc086C.Main do

  require Integer

  def main() do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    1..n
    |> Enum.reduce_while(["No", 0, 0, 0], fn _, [_, pt, px, py] ->
      [t, x, y] = IO.read(:line) |> String.split(" ") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)

      # 時間
      dt = t - pt

      # 距離　
      d = abs(x - px) + abs(y - py)

      if dt >= d and Integer.is_even(dt) == Integer.is_even(d) do
        {:cont,  ["Yes", t, x, y]}
      else
        {:halt,  ["No"]}
      end
    end)
    |> List.first()
    |> IO.puts()
  end
end
