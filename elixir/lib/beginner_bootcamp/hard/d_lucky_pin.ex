defmodule LuckyPin.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main do
    _ = read_single()

    nums =
      IO.read(:line)
      |> String.trim
      |> String.to_integer()
      |> Integer.digits()
      |> Enum.with_index()

    (for i <- 0..9, j <- 0..9, k <- 0..9, do: [i, j, k])
    |> solve(nums, 0)
    |> IO.puts()
  end

  def solve([], _, acc), do: acc
  def solve([[i, j, k] | t], nums, acc) do
    with {_, [{_, pos_i} | rest]} <- Enum.split_while(nums, fn {v, _} -> v != i end),
      {_, [{_ , pos_j} | rest]} when pos_i < pos_j <- Enum.split_while(rest, fn {v, _} -> v != j end),
      {_, [{_ , pos_k} | _]}  when pos_j < pos_k <- Enum.split_while(rest, fn {v, _} -> v != k end)
    do
      IO.inspect([i, j, k])
      solve(t, nums, acc + 1)
    else
      _ -> solve(t, nums, acc)
    end
  end

end
