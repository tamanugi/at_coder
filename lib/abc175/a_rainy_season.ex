defmodule RanySeason.Main do

  def main() do
    s = IO.read(:line) |> String.trim()

    cond do
      String.contains?(s, "RRR") -> 3
      String.contains?(s, "RR") -> 2
      String.contains?(s, "R") -> 1
      true -> 0
    end
    |> IO.puts()
  end

end
