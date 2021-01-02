defmodule CutAndCount.Main do

  def main() do
    _ = IO.read(:line)
    s = IO.read(:line) |> String.trim() |> String.split("") |> Enum.filter(&(String.length(&1) > 0))

    solve(s, 1, 0)
    |> IO.puts()
  end

  def solve(s, i, acc) when i == length(s), do: acc
  def solve(s, i, acc) do
    {s1, s2} = Enum.split(s, i)
    s1 = s1 |> Enum.uniq() |> Enum.sort()
    s2 = s2 |> Enum.uniq() |> Enum.sort()

    acc =
      s1
      |> Enum.filter(fn c1 -> Enum.member?(s2, c1) end)
      |> Enum.count()
      |> max(acc)

    solve(s, i + 1, acc)
  end

end
