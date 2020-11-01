defmodule TemplateMatching.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, m] = read_array()

    as =
      1..n
      |> Enum.map(fn _ -> IO.read(:line) |> String.trim() |> String.codepoints() |> Enum.with_index() end)
      |> Enum.with_index()
      |> Enum.map(fn {s, i} -> s |> Enum.map(fn {c, j} -> {{i, j}, c} end) end)
      |> List.flatten()
      |> Map.new()
    bs =
      1..m
      |> Enum.map(fn _ -> IO.read(:line) |> String.trim() |> String.codepoints() |> Enum.with_index() end)
      |> Enum.with_index()
      |> Enum.map(fn {s, i} -> s |> Enum.map(fn {c, j} -> {{i, j}, c} end) end)
      |> List.flatten()
      |> Map.new()

    (for y <- 0..(n-1), x <- 0..(n-1), do: {y, x})
    |> solve(as, bs, m - 1)
    |> IO.puts
  end

  def solve([], _as, _bs, _m), do: "No"
  def solve([{y, x} | t], as, bs, m) do
    c1 = Map.get(as, {y, x})
    c2 = Map.get(bs, {0, 0})

    if c1 == c2 do
      checks = (for j <- 0..m, i <- 0..m, j != 0 or i != 0, do: {y + j, x + i, j, i})
      if same?(checks, as, bs) do
        "Yes"
      else
        solve(t, as, bs, m)
      end
    else
      solve(t, as, bs, m)
    end
  end

  def same?([], _as, _bs), do: true
  def same?([{ay, ax, by, bx} | t], as, bs) do
    c1 = Map.get(as, {ay, ax})
    c2 = Map.get(bs, {by, bx})

    if c1 == c2 do
      same?(t, as, bs)
    else
      false
    end
  end

end
