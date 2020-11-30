defmodule CardEater.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    as = read_array()

    freq = Enum.frequencies(as)

    freq
    |> Map.values()
    # 奇数個の場合は自身を3つ選べば1つになるので
    # 偶数のもののみ考える
    |> Enum.filter(fn i -> rem(i, 2) == 0 end)
    |> Enum.count()
    # 偶数個のものが偶数個あれば0, 奇数個なら-1
    |> rem(2)
    |> Kernel.-(map_size(freq))
    |> abs()
    |> IO.puts()

  end

end
