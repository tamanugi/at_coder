defmodule GridColoring.Main do
  require Integer

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, w] = read_array()
    _ = read_single()
    as = read_array() |> Enum.with_index(1)

    as
    |> Enum.sort_by(fn {c, _} -> c end, :desc)
    |> Enum.map(fn {c, i} -> (for _ <- 1..c, do: "#{i}") end)
    |> List.flatten()
    |> Enum.chunk_every(w)
    |> Enum.with_index()
    |> Enum.map(fn {s, i} -> if rem(i, 2) == 0, do: s, else: Enum.reverse(s) end)
    |> Enum.map(fn s -> s |> Enum.join(" ") end)
    |> Enum.join("\n")
    |> IO.puts()
  end

end
