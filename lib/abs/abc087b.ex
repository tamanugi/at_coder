defmodule Abc087B.Main do

  def main() do
    a = IO.read(:line) |> String.trim() |> String.to_integer()
    b = IO.read(:line) |> String.trim() |> String.to_integer()
    c = IO.read(:line) |> String.trim() |> String.to_integer()
    # 考えやすくするために50で割る
    x = IO.read(:line) |> String.trim() |> String.to_integer() |> div(50)

    solve(a, b, c, x)
    |> IO.puts
  end

  def solve(a, b, c, x) do
    m500 = can_max_count(10, a, x)

    0..m500
    |> Enum.reduce(0, fn n500, res ->

      xx =
        x - (10 * n500)

      if xx > 0 do
        # 100円の使用枚数
        m100 = can_max_count(2, b, xx)

        r = 0..m100
        |> Enum.reduce(0, fn n100, acc ->
          xxx = xx - (2 * n100)

          if c >= xxx, do: acc + 1, else: acc
        end)

        res + r
      else
        res + 1
      end
    end)
  end

  def can_max_count(_, 0, _), do: 0
  def can_max_count(coin, n, x) do
    Enum.min([div(x, coin), n])
  end

end
