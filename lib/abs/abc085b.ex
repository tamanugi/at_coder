defmodule Abc085B.Main do

  def main() do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    1..n
    |> Enum.map(fn _ -> IO.read(:line) end)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.uniq()
    |> length()
    |> IO.puts()

  end
end
