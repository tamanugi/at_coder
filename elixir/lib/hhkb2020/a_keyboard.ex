defmodule Keyboard.Main do

  def main() do
    IO.read(:line)
    |> String.trim()
    |> solve()
    |> IO.puts()
  end

  def solve("Y") do
    IO.read(:line)
    |> String.trim()
    |> String.upcase()
  end

  def solve("N") do
    IO.read(:line)
    |> String.trim()
  end
end
