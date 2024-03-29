defmodule Abc195.A.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [m, h] = read_array()

    case rem(h, m) do
      0 -> "Yes"
      _ -> "No"
    end
    |> IO.puts()
  end
end
