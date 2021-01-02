defmodule DontBeLate.Main do
  def main() do
    [d, t, s] = read_array()

    if d / s <= t do
      "Yes"
    else
      "No"
    end
    |> IO.puts()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

end
