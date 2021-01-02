defmodule Arc109.A.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [a, b, x, y] = read_array()

    cond do
      a == b -> x
      a > b ->
        c = a - b - 1
        # 1階下がる + c - 1階下がるのに
        min(x, x + y) + min(2 * x * c, c * y)
      a < b ->
        c = b - a - 1
        # 1階上がる + c - 1階あがるのに
        min(3 * x, x + y) + min(2 * x * c, c * y)
    end
    |> IO.puts()
  end

end
