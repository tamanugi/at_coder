defmodule Substring.Main do
  def main() do
    s = IO.read(:line) |> String.trim()
    t = IO.read(:line) |> String.trim()

    unless String.contains?(s, t) do
      solve(s, t)
    else
      0
    end
    |> IO.puts()
  end

  def solve(s, t) do
    ss = s |> String.split("") |> Enum.filter(& (&1 != ""))
    tt = t |> String.split("") |> Enum.filter(& (&1 != ""))

    solve(ss, tt, length(tt), 0)
  end

  def solve(s, _, t_size, acc) when length(s) < t_size, do: t_size - acc
  def solve([_ | tail] = s, t, t_size, acc) do

    count =
      s
      |> Enum.take(t_size)
      |> Enum.zip(t)
      |> Enum.count(fn {sss, ttt} -> sss == ttt end)

    solve(tail, t, t_size, max(count, acc))
  end

end
