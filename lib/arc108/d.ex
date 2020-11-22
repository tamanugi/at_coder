defmodule AB.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main do
    n = read_single()
    [caa, cab, cba, cbb] = IO.read(:all) |> String.split("\n") |> Enum.map(fn s -> String.trim(s) end) |> Enum.filter(fn s -> s != "" end)

  end

  def solve("A", "A", _, _), do: 1
  def solve("A", _, "A", _), do: 1
  def solve(_, "B", _, "B"), do: 1

  def solve("B", "A", "A", _), do: 1

end
