defmodule B121.Main do

  def main() do
    n = IO.read(:line) |> String.trim() |> String.replace(" ", "") |> String.to_integer()

    i = :math.sqrt(n) |> floor()

    (if i * i == n, do: "Yes", else: "No")
    |> IO.puts()
  end

end
