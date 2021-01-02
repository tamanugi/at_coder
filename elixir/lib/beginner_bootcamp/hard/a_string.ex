defmodule STring.Main do

  def main() do
    s = IO.read(:line) |> String.trim()
    s |> solve() |> IO.puts()
  end

  def solve(_, lr \\ {0, 0})
  def solve("", {l, r}), do: l + r
  def solve("S" <> rest, {l, r}), do: solve(rest, {l, r + 1})
  def solve("T" <> rest, {l, r}) do
    r = r - 1
    {l, r} = if r < 0, do: {l + 1, 0}, else: {l, r}
    solve(rest, {l, r})
  end

end
