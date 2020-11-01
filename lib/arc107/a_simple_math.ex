defmodule SimpleMath.Main do
  @mod 998244353

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [a, b, c] = read_array()

    a = 1..a |> Enum.sum() |> rem(@mod)
    b = 1..b |> Enum.sum() |> rem(@mod)
    c = 1..c |> Enum.sum() |> rem(@mod)

    ans = rem(a * b, @mod)
    ans = rem(ans * c, @mod)
    ans |> IO.puts()
  end

end
