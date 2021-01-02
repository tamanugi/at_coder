defmodule BackAndForth.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [sx, sy, tx, ty] = read_array()

    {tx - sx, ty - sy}
    |> solve()
    |> IO.puts()
  end

  def solve({dx, dy}) do
    # 1回目の往路
    s1 =  ud(dy) <> rl(dx)
    # 1回目の復路
    t1 = return(s1)

    # 2回目の往路
    dx = if dx > 0, do: dx + 1, else: dx - 1
    dy = if dy > 0, do: dy + 1, else: dy - 1
    s2 = (if dx > 0, do: "L", else: "R") <> ud(dy) <> rl(dx) <> (if dy > 0, do: "D", else: "U")

    # 2回目の復路
    t2 = return(s2)

    s1 <> t1 <> s2 <> t2
  end

  def ud(n) when n < 0, do: String.duplicate("D", abs(n))
  def ud(n), do: String.duplicate("U", n)
  def rl(n) when n < 0, do: String.duplicate("L", abs(n))
  def rl(n), do: String.duplicate("R", n)

  def return(s) do
    s
    |> String.codepoints()
    |> Enum.map(fn
      "U" -> "D"
      "D" -> "U"
      "L" -> "R"
      "R" -> "L"
    end)
    |> Enum.join("")
  end

  def check(s, sx, sy, tx, ty) do
    IO.inspect({sx, sy}, label: "S")

    s
    |> String.codepoints()
    |> Enum.map(fn
      "U" -> {0, 1}
      "D" -> {0, -1}
      "L" -> {-1, 0}
      "R" -> {1, 0}
    end)
    |> Enum.reduce({sx, sy}, fn {dx, dy},{x, y} ->
      {x, y} = {x + dx, y + dy}
      label =
        case {x, y} do
          {^sx, ^sy} -> "S"
          {^tx, ^ty} -> "G"
          _ -> " "
        end

      IO.inspect({x, y}, label: label)
    end)

    "test"
  end

end
