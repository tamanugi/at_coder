defmodule Abc081B.Main do

  def main() do

    _ = IO.read(:line)
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    # 2進数の配列に変換する
    |> Enum.map(&Integer.digits(&1, 2))
    # 各配列で末尾の0の個数を数えればOK
    |> solve(nil)
    |> IO.inspect()
  end

  def solve([], acc), do: acc
  def solve([h | t], acc) do
    zero_count = h
    # 数えやすいように逆順にする
    |> Enum.reverse()
    |> Enum.reduce_while(0, fn i, count ->
      case i do
        0 -> {:cont, count + 1}
        1 -> {:halt, count}
      end
    end)

    solve(t, Enum.min([zero_count, acc]))
  end

end
