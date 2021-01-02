defmodule KleeneInversion.Main do
  @mod 1000_000_000 + 7

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, k] = read_array()

    as = read_array()

    {r, t} = solve(as, as, 0, 0)

    ans = r * k
    ans = ans + total(k, t)

    ans
    |> rem(@mod)
    |> IO.puts()
  end

  def total(k, total) do
    k * (k - 1)
    |> div(2)
    |> Kernel.*(total)
  end

  def solve([], _, r, total), do: {r, total}
  def solve([h | t], as, r, total) do
    # 自身より右にあるものの個数
    r = r + Enum.count(t, fn i -> h > i end)

    # 位置関係なく低いものの個数　
    total = total + Enum.count(as, fn i -> h > i end)

    solve(t, as, r, total)
  end

end
