defmodule Arc110.C.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    res =
      read_array()
      |> Enum.with_index(1)
      |> Enum.map(fn {v, i} -> {i - v, i} end)
      |> solve(0, [])

    case res do
      :no -> -1
      res ->
        res
        |> Enum.sort_by(fn {p, _} -> p end, :desc)
        |> Enum.map(fn {_, i} -> i end)
        |> Enum.join("\n")
    end
    |> IO.puts()
  end

  def solve([], 0, acc), do: acc
  def solve([{v, _}], check, acc) when check + v == 0, do: acc
  def solve([{0, _}, _ | _t], _, _), do: :no
  def solve([{-1, _}, {1, _} | _t], check, _) when check > 0, do: :no
  def solve([{v, i}, {v2, i2} | t], check, acc) do
    # iの操作の優先度
    pri = v * -1 + v2
    solve([{v2, i2} | t], check + v, [{pri, i} | acc])
  end
  def solve(_, _, _), do: :no
end
