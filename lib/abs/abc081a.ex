defmodule Abc081A.Main do

  def main() do
    IO.read(:line)
    |> String.trim()
    |> String.replace(~r(0), "")
    |> String.length()
    |> IO.puts()
  end

end
