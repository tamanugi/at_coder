defmodule PreparingBoxes.Main do
  use Bitwise

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()
    as = read_array() |> Enum.with_index(1) |> Enum.reverse()

    res = solve(as, %{}, n, [])

    IO.puts(length(res))
    case res do
      [] -> :no
      _ -> res |> Enum.join(" ") |> IO.puts()
    end
  end

  def solve([], _m, _n, acc), do: acc
  def solve([{a, i} | t], m, n, acc) do
    c = check(m, i, i, n, 0)
    p = rem(c, 2) ^^^ a

    if p == 1 do
      m = Map.put(m, i, p)
      solve(t, m, n, [i | acc])
    else
      solve(t, m, n, acc)
    end

  end

  def check(_m, i, _f, n, acc) when i > n, do: acc
  def check(m, i, f, n, acc) do
    acc = acc + Map.get(m, i, 0)
    check(m, i + f, f, n, acc)
  end

end
