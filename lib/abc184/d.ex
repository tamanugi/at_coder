defmodule Abc184.D.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [a, b, c] = read_array()

    (for i <- 99..a, j <- 99..b, k <- 99..c, i + j + k > 0, do: {i,j,k})
    |> Enum.reduce(%{}, fn {i, j, k}, dp ->
      s = i + j + k
      ii = Map.get(dp, key(i + 1, j, k), 0) * i/s
      jj = Map.get(dp, key(i, j + 1, k), 0) * j/s
      kk = Map.get(dp, key(i, j, k + 1), 0) * k/s

      Map.put(dp, key(i, j, k), ii + jj + kk + 1)
    end)
    |> Map.get(key(a, b, c))
    |> IO.puts()
  end

  def key(i, j, k), do: i * 1000 * 1000 + j * 1000 + k
end
