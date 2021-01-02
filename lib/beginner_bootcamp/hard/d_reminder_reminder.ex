defmodule ReminderReminder.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, k] = read_array()

    k+1..n
    |> solve(k, 0)
    |> IO.puts()
  end

  def solve(_..n, 0, _), do: n * n
  def solve(i..n, _, acc) when i > n, do: acc
  def solve(i..n, k, acc) do
    acc = acc + max(rem(n, i) - (k - 1), 0)
    acc = acc + (div(n, i) * (i - k))
    solve(i+1..n, k, acc)
  end

end
