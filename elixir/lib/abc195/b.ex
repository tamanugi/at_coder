defmodule Abc195.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [a, b, w] = read_array()
    w = w * 1000

    # 最大値
    a..b
    |> Enum.map(fn x ->
      case {rem(w, x), div(w, x)} do
        {0, s} -> s
        {r, d} ->
          d..1
      end
    end)
  end
end
