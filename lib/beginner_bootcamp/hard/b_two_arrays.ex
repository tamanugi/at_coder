defmodule TwoArrays.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    a = read_array()
    b = read_array()


    a_sum = Enum.sum(a)
    b_sum = Enum.sum(b)

    case b_sum - a_sum do
      i when i < 0 -> "No"
      0 ->
        if a == b, do: "Yes", else: "No"
      _ ->
        c =
          diff(a, b, [])
          |> Enum.reduce({0, 0}, fn d, {l, r} ->
            case d do
              0 -> {l, r}
              i when i < 0 -> {l + div(abs(i), 2), r}
              i when i > 0 -> {l, r + i}
            end
          end)
          |> (fn {l, r} -> l >= r end).()

        if c, do: "Yes", else: "No"
    end
    |> IO.puts()
  end

  def diff([], [], acc), do: acc
  def diff([ah | at], [bh | bt], acc) do
    diff(at, bt, [ah - bh | acc])
  end

end
