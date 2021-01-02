defmodule RedAndGreenApples.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [x, y, _a, _b, _c] = read_array()

    red = read_array() |> Enum.sort(:desc) |> Enum.take(x)
    green = read_array() |> Enum.sort(:desc) |> Enum.take(y)
    white = read_array()

    (red ++ green ++ white)
    |> Enum.sort(:desc)
    |> Enum.take(x + y)
    |> Enum.sum()
    |> IO.puts()
  end

  def solve(_, _, _, acc \\ 0)

  def solve([], [], _, acc), do: acc
  def solve(red, green, [], acc), do: acc + Enum.sum(red) + Enum.sum(green)
  def solve([], [q | _] = green, [r | _], acc) when q >= r, do: acc + Enum.sum(green)
  def solve([], [q | gt], [r | wt], acc) when q < r, do: solve([], gt, wt, acc + r)
  def solve([p | _] = red, [], [r | _], acc) when p >= r, do: acc + Enum.sum(red)
  def solve([p | rt], [], [r | wt], acc) when p < r, do: solve(rt, [], wt, acc + r)

  def solve([p | rt] = red, [q | gt] = green, [r | wt] = white, acc) do
    eat = Enum.max([p, q, r])

    acc = acc + eat
    {red, green, white} =
      case eat do
        # 赤
        ^p -> {rt, green, white}
        # 緑
        ^q -> {red, gt, white}
        # 無
        ^r when p <= q ->
          {rt, green, wt}
        ^r when p > q ->
          {red, gt, wt}
      end

    solve(red, green, white, acc)
  end

end
