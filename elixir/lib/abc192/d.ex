defmodule Abc192.D.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end
  def read_s() do
    IO.read(:line) |> String.trim()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    x = read_s()
    m = read_single()

    unless String.length(x) == 1 do
      process(x, m)
    else
      if String.to_integer(x) <= m, do: 1, else: 0
    end
    |> IO.puts()

  end

  def process(x, m) do

    arr = x |> String.codepoints() |> Enum.map(&String.to_integer/1)
    d = arr |> Enum.max()

    # 桁数
    ddd = arr |> length()

    # 先頭の数字
    first = arr |> List.first()

    # Mに近いn進数の候補
    candinate =
      :math.pow(div(m, first), 1 / max(ddd - 1, 1))
      |> floor()

    candinate = max(candinate - 5, d + 1)

    if candinate > d do
      solve(arr, d, m, candinate, candinate - d - 1)
    else
      0
    end
  end

  def solve(x, d, m, n, acc) do
    if Integer.undigits(x, n) > m do
      acc
    else
      solve(x, d, m, n + 1, acc + 1)
    end
  end

end
