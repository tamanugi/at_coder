defmodule Main do
  def main() do
    a = IO.read(:line) |> String.trim() |> String.to_integer()
    [b, c] = IO.read(:line) |> String.split(" ") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)
    s = IO.read(:line)

    IO.puts("#{a + b + c} #{s}")
  end
end
