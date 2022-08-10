defmodule Abc263.D.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, l, r] = read_array()
    a = read_array()

    ans = r * n
    solve(a, n, l, r, 0, 0, ans)
    |> IO.puts()
  end

  def solve([], _n, _, _, _, _, ans), do: ans
  def solve([h | t], n,  l, r, i, sum, ans) do
    # Lでどこまで埋めるか
    sum = min(sum + h, l * (i + 1))
    # 残りをRで埋めた場合
    ans = min(ans, sum + r * (n - i - 1))
    solve(t, n, l, r, i + 1, sum, ans)
  end
end
