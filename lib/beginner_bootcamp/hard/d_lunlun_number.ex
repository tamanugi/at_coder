defmodule LunlunNumber.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    k = read_single()

    q = {[1,2,3,4,5,6,7,8,9] |> Enum.reverse, []}
    solve(q, 1..k)
    |> IO.puts()
  end

  def solve(q, k..k) do
    {{:value, v}, _}  = :queue.out(q)
    v
  end
  def solve(q, i..k) do
    {{:value, s}, q} = :queue.out(q)
    ii = rem(s, 10)

    q =
      (for j <- -1..1, ii + j >= 0 and ii + j <= 9, do: ii + j)
      |> Enum.map(fn i -> s * 10 + i end)
      |> Enum.reduce(q, fn i, q ->
        :queue.in(i, q)
      end)

    solve(q, i+1..k)
  end
end
