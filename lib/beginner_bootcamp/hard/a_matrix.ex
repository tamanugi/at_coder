defmodule Matrix.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [h, w, a, b] = read_array()

    0..(h - 1)
    |> Enum.map(fn i ->
      {l, r} = if i < b, do: {0, 1}, else: {1, 0}
      (for j <- 0..(w - 1), do: (if j < a, do: l, else: r)) |> Enum.join("")
    end)
    |> Enum.join("\n")
    |> IO.puts()
  end

end
