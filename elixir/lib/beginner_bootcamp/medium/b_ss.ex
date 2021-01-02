defmodule SS.Main do
  require Integer

  def main() do
    s =
      IO.read(:line)
      |> String.trim()
      |> String.reverse()

    solve(s)
    |> IO.puts()
  end

  def solve(<<_>> <> s) do
    with l <- String.length(s),
     true <- Integer.is_even(l),
     {s1, s2} when s1 == s2 <- String.split_at(s, div(l, 2))
    do
      l
    else
      _ -> solve(s)
    end
  end

end
