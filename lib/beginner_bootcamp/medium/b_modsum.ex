defmodule ModSum.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()
    if n > 1 do
      Enum.sum(1..n-1)
      |> IO.puts()
    else
      IO.puts(0)
    end
  end
end
