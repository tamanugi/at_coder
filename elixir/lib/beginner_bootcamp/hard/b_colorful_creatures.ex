defmodule ColorfulCreatures.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end


  def main() do
    _ = read_single()
    as = read_array()

    as = as |> Enum.sort()

    s = sum(as)
    as = Enum.reverse(as)

    solve(as, s, 1)
    |> IO.puts()
  end

  def sum([h | t]), do: sum(t, [h, 0])
  def sum([_], acc), do: acc
  def sum([h | t], [p | _] = acc) do
    sum(t, [h + p | acc])
  end

  def solve([], [], acc), do: acc
  def solve([h | t], [sh | st], acc) do
    if 2 * sh >= h do
      solve(t, st, acc + 1)
    else
      acc
    end
  end

end
