defmodule To3.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    s = IO.read(:line) |> String.trim() |> String.codepoints() |> Enum.map(&String.to_integer/1)

    unless sum_is_three?(s)  do
      n = length(s)
      case solve(n - 1, s) do
        nil -> -1
        i  -> n - i
      end
    else
      0
    end
    |> IO.puts()
  end

  def solve(0, _as), do: nil
  def solve(n, as) do
    res =
      combination(as, n)
      |> Enum.reduce_while(:no, fn s, _ ->
        if sum_is_three?(s) do
          {:halt, :ok}
        else
          {:cont, :no}
        end
      end)

    case res do
      :ok -> n
      :no -> solve(n - 1, as)
    end

  end

  def sum_is_three?(s) do
    (Enum.sum(s) |> rem(3)) == 0
  end

  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end

end
