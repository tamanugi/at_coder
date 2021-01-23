defmodule Keyence2021.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_n, k] = read_array()

    [a | rest] =
      read_array()
      |> Enum.frequencies()
      |> Map.to_list()
      |> Enum.sort_by(fn {i, _} -> i end)

    case a do
      {0, count} -> solve(rest, 0, min(count, k), 0)
      _ -> 0
    end
    |> IO.puts()
  end

  def solve([], pre, k, acc) do
    (pre + 1) * k + acc
  end

  def solve([{idx, num} | t], pre, k, acc) do
    if idx - pre == 1 do
      if num - k >= 0 do
        solve(t, idx, k, acc)
      else
        solve(t, idx, num, acc + (idx) * (k - num))
      end
    else
      (pre + 1) * k + acc
    end
  end
end
