defmodule RangeFlipFindRoute.Main do
  @inf 1000_000

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def split_and_filter(s) do
    s
    |> String.split("")
    |> Enum.filter(&(String.length(&1) > 0))
  end

  def main() do
    [h, w] = read_array()

    cell =
      IO.read(:all)
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.flat_map(&split_and_filter/1)

    # スタート位置のコスト
    init_cost = if Enum.at(cell, 0) == "#", do: 1, else: 0
    dp = Map.put(%{}, 0, init_cost)

    solve(cell, dp, 1, w, h * w)
    |> IO.puts()
  end

  def solve(_, dp, i, _, size) when i == size, do: dp[size - 1]
  def solve(cell, dp, i, w, size) do
    # 上から来た場合
    v1 =
      case i - w do
        ii when ii >= 0 ->
          Map.get(dp, i - w) + if Enum.at(cell, i - w) == "." and Enum.at(cell, i) == "#", do: 1, else: 0
        _ -> @inf
      end

    # 左から来た場合
    v2 =
      case i - 1 do
        _ when rem(i, w) == 0 -> @inf
        ii ->
          Map.get(dp, ii) + if Enum.at(cell, ii) == "." and Enum.at(cell, i) == "#", do: 1, else: 0
      end

    dp =  Map.put(dp, i, min(v1, v2))

    solve(cell, dp, i + 1, w, size)
  end


end
