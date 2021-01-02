defmodule Contrast.Main do
  def main() do
    n = read_single()
    a = read_array()
    b = read_array() |> Enum.reverse()

    m = [a, b] |> Enum.flat_map(&(&1)) |> Enum.frequencies() |> Map.values() |> Enum.max()


    if m <= n do
      solve(a, b)
    else
      "No" |> IO.puts()
    end
  end

  def solve(a, b) do

    with s when is_integer(s) <- find_same(a, b) do
      IO.inspect(s)
    else
      _ ->
        IO.puts("Yes")
        IO.puts(Enum.join(b, " "))
    end

  end

  def find_same([], []), do: :not_found
  def find_same([ha | ta], [hb | tb]) do
    if ha == hb do
      ha
    else
      find_same(ta, tb)
    end
  end


  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

end
