defmodule B.Abc.Main do

  def main() do
    s = IO.read(:line) |> String.trim()

    solve(s, 0, 0)
    |> IO.puts()
  end

  def solve("", _, acc), do: acc
  def solve("A" <> rest, cnt, acc), do: solve(rest, cnt + 1, acc)
  def solve("BC" <> rest, cnt, acc), do: solve(rest, cnt, acc + cnt)
  def solve(<<_::utf8>> <> rest, _, acc), do: solve(rest, 0, acc)

end
