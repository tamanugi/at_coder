defmodule PowerfulDiscountTickets.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, m] = read_array()
    as = read_array() |> Enum.sort(:desc)

    solve(as, [], m)
    |> IO.puts()
  end

  def solve(as, acc, 0), do: Enum.sum(as) + Enum.sum(acc)
  def solve([h | t], [], m), do: solve(t, [div(h, 2)], m - 1)
  def solve([], [qh | qt], m), do: solve([], append_tail(qt, div(qh, 2))  , m - 1)
  def solve([h | t] = as, [qh | qt] = acc, m) do

    {as, acc} =
      if qh > h do
        {as, append_tail(qt, div(qh, 2))}
      else
        {t, append_tail(acc, div(h, 2))}
      end

    solve(as, acc, m - 1)
  end

  def append_tail(list, element) do
    # This functions is bottleneck....
    # list ++ [element]
    [element | Enum.reverse(list)] |> Enum.reverse()
  end

  def test_case do
    as = for i <- 10000..1, do: i
    {runtime, result} =  :timer.tc(&solve/3, [as, [], 100000])

    # We have to make sure the run time is less than 2 seconds.
    IO.inspect([runtime: runtime, result: runtime < 2000_000])
    IO.inspect(result == 31358)
  end

end
