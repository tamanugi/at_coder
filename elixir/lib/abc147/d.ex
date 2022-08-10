defmodule Abc147.D.Main do
  @mod 1000_000_007
  import Bitwise

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    _ = read_single()
    nums = read_array()

    for i <- 0..60 do
      mask = pow(2, i)

      {zero, one} =
        nums
        |> Enum.reduce({0, 0}, fn num, {zero, one}->
          case num &&& mask do
            0 -> {zero + 1, one}
            _ -> {zero, one + 1}
          end
        end)

      zero * one * mask
    end
    |> Enum.sum()
    |> rem(@mod)
    |> IO.puts()
  end

  def pow(_, 0), do: 1
  def pow(x, y), do: :math.pow(x, y) |> floor()
end
