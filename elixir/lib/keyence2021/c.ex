defmodule Keyence2021.C.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def repeat(char, count) do
    for _ <- 1..count, do: char
  end

  def main() do
    n = read_single()
    x = floor(:math.pow 2, n)

    xx = div(x, 2)

    source = (for _i <- 1..(x-1), do: "B")

    (for i <- 1..(x-1), do: i)
    |> combination(xx - 1)
    |> IO.inspect()
    |> Enum.map(fn s ->
      s
      |> Enum.reduce(source, fn i, acc ->
        List.update_at(acc, i - 1, fn _ -> "A" end)
      end)
      |> Enum.join("")
    end)
    |> Enum.map(fn s -> "A" <> s end)
    |> Enum.join("\n")
    |> IO.puts()

  end

  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end
end
