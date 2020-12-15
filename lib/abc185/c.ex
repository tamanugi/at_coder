defmodule Abc185.C.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    read_single()
    |> Kernel.-(1)
    |> combi(11)
    |> IO.puts()
  end

  def combi(a, b) do
    a = a..(a - b + 1) |> Enum.reduce(fn i, acc -> i * acc end)
    b = b..1 |> Enum.reduce(fn i, acc -> i * acc end)
    div(a, b)
  end

end
