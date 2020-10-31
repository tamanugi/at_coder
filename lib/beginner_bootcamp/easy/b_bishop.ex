defmodule Bishop.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [h, w] = read_array()

    (if h == 1 or w == 1, do: 1, else: ceil((h * w)/2))
    |> IO.puts()
  end

end
