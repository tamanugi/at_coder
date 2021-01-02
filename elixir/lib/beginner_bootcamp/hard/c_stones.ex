defmodule Stones.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    _ = read_single()
    s = IO.read(:line) |> String.trim() |> String.split("") |> Enum.filter(&(String.length(&1) > 0))

    f = s |> Enum.frequencies()

    unless map_size(f) == 1 do
      solve(s, f, {0, 0}, nil)
    else
      # 一色しかないばあい
      0
    end
    |> IO.puts()

  end

  def solve([], f, {b, w}, ans) do
    min(b + Map.get(f, ".", 0) - w, ans)
  end
  def solve([h | t], f, {b, w}, ans) do
    ans = min(b + Map.get(f, ".", 0) - w, ans)

    # 左にある # の数 + 右にある . の数
    {b, w} =
      case h do
        "#" -> {b + 1, w}
        "." -> {b, w + 1}
      end

    solve(t, f, {b, w}, ans)
  end

end
