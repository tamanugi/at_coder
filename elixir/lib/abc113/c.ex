defmodule Abc113.C.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Stream.with_index()
    |> Stream.map(fn {[p, y], i} -> {p, y, i} end)
    |> Enum.to_list()
  end

  def main() do
    [_, _] = read_array()

    read_multi_array()
    |> Enum.sort_by(&{elem(&1, 0), elem(&1, 1)})
    |> solve(1, -1, [])
    |> Enum.sort_by(&elem(&1, 2))
    |> Enum.map(fn {p, n, _} ->
      s1 = String.pad_leading("#{p}", 6, "0")
      s2 = String.pad_leading("#{n}", 6, "0")
      "#{s1}#{s2}"
    end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  def solve([], _, _, acc), do: acc
  def solve([{p, _, i} | t], num, prep, acc) do
    num = if p == prep, do: num, else: 1
    solve(t, num + 1, p, [{p, num, i} | acc])
  end
end
