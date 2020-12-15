defmodule Abc185.E.Main do
  @inf 1000_000_000

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, m] = read_array()
    a = read_array() |> Enum.with_index() |> Enum.map(fn {v, i} -> {i, v} end) |> Map.new()
    b = read_array() |> Enum.with_index() |> Enum.map(fn {v, i} -> {i, v} end) |> Map.new()

    # solve(0..n+1, 0..m+1, a, b, %{0 => 0})
    :timer.tc(Abc185.E.Main, :solve, [0..n+1, 0..m+1, a, b, %{0 => 0}])
    |> IO.inspect()
  end

  def solve(na..na, nb..nb, _, _, dp) do
    dp[key(na - 1, nb - 1)]
  end

  def solve(i..na, nb..nb, a, b, dp) do
    solve(i+1..na, 0..nb, a, b, dp)
  end

  def solve(i..na, j..nb, a, b, dp) do
    # Aiを消すとき
    v1 = if i > 0, do: dp[key(i - 1, j)] + 1, else: @inf

    # Bjを消すとき
    v2 = if j > 0, do: dp[key(i, j - 1)] + 1, else: @inf

    # AiとBjが合うようにするとき
    v3 =
      if i > 0 and j > 0 do
        s = if a[i - 1] == b[j - 1], do: 0, else: 1
        dp[key(i - 1, j - 1)] + s
      else
        @inf
      end

    dp =
      case Enum.min([v1, v2, v3]) do
        @inf -> dp
        v ->
          Map.put(dp, key(i, j), v)
      end

    solve(i..na, j+1..nb, a, b, dp)
  end

  def key(i, j), do: i * 10000 + j
end
