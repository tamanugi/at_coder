defmodule AlmostGCD.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    as = read_array()

    {r, _} =
      divisors(as, [])
      |> Enum.frequencies()
      |> Map.to_list()
      |> Enum.max_by(fn {_, c} -> c end)

    IO.puts(r)
  end

  def divisors([], acc), do: acc |> List.flatten()
  def divisors([h | t], acc) do
    a = :math.sqrt(h) |> floor()

    if a >= 2 do
      d = 2..a
      |> Enum.filter(fn i -> rem(h, i) == 0 end)
      |> Enum.map(fn i -> [i, div(h, i)] |> Enum.uniq end)

      divisors(t, [h, d | acc])
    else
      divisors(t, [h | acc])
    end

  end

end
