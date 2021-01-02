defmodule HeabyRotation.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    case rem(read_single(), 2) do
      0 -> "White"
      1 -> "Black"
    end
    |> IO.puts()

  end

end
