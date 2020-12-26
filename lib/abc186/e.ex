defmodule Abc186.E.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def main() do
    _ = read_single()
    q = read_multi_array()

    solve(q, [])
    |> IO.puts()
  end

  def solve([], acc), do: acc |> Enum.reverse() |> Enum.join("\n")
  def solve([[n, s, k] | t], acc) do
    # gcdをとる
    g = Integer.gcd(n, k)
    res =
      if rem(s, g) == 0 do
        n = div(n, g)
        s = div(s, g)
        k = div(k, g)

        Integer.mod(inverse(k, n) * -1 * s, n)
      else
        -1
      end
    solve(t, [res | acc])
  end

  def extended_gcd(a, b) do
    {last_remainder, last_x} = extended_gcd(a, b, 1, 0, 0, 1)
    {last_remainder, last_x}
  end

  defp extended_gcd(last_remainder, 0, last_x, _, _, _), do: {last_remainder, last_x}
  defp extended_gcd(last_remainder, remainder, last_x, x, last_y, y) do
    quotient   = div(last_remainder, remainder)
    remainder2 = Integer.mod(last_remainder, remainder)
    extended_gcd(remainder, remainder2, x, last_x - quotient*x, y, last_y - quotient*y)
  end

  def inverse(e, et) do
    {g, x} = extended_gcd(e, et)
    if g != 1, do: raise "The maths are broken!"
    rem(x+et, et)
  end
end
