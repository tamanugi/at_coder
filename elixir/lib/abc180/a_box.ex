defmodule Box.Main do
  def main() do
    [n, a, b] = read_array()

    (n - a + b)
    |> IO.puts

  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

end
