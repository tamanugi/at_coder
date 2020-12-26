defmodule Abc186.C.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()

    1..n
    |> Enum.reject(fn i -> Integer.digits(i) |> Enum.member?(7) end)
    |> Enum.reject(fn i -> Integer.digits(i, 8) |> Enum.member?(7) end)
    |> Enum.count
    |> IO.puts()
  end
end
