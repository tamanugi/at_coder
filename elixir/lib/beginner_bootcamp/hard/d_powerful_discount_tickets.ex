defmodule PowerfulDiscountTickets.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, m] = read_array()
    as = read_array() |> Enum.sort(:desc)

    solve(as, m)
    |> IO.puts()
  end

  def solve([h | t], m), do: solve(t, {[], [div(h, 2)]}, m - 1)
  def solve(as, {l, r}, 0), do: Enum.sum(as) + Enum.sum(l) + Enum.sum(r)
  def solve([], q, m) do
    {{:value, qh}, rest} = :queue.out(q)
    solve([], :queue.in(div(qh, 2), rest)   , m - 1)
  end
  def solve([h | t] = as, q, m) do
    {{:value, qh}, rest} = :queue.out(q)
    {as, q} =
      if qh > h do
        {as, :queue.in(div(qh, 2), rest)}
      else
        q = :queue.in(div(h, 2), rest)
        q = :queue.in_r(qh, q)
        {t, q}
      end

    solve(as, q, m - 1)
  end

  def test_case do
    as = for i <- 10000..1, do: i
    {runtime, result} =  :timer.tc(&solve/2, [as, 100000])

    # We have to make sure the run time is less than 2 seconds.
    IO.inspect([runtime: runtime, result: runtime < 2000_000])
    IO.inspect(result == 31358)
  end

end
