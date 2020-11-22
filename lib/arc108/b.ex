defmodule Arc108.B.Main do

  def main() do
    _ = IO.read(:line)
    s = IO.read(:line) |> String.trim()

    solve(s, [], 0)
    |> IO.puts()
  end

  def solve("", [], acc), do: acc
  def solve("", t, acc), do: acc + length(t)
  def solve("f" <> rest, stack, acc), do: solve(rest, ["f" | stack], acc)
  def solve("o" <> rest, stack, acc), do: solve(rest, ["o" | stack], acc)
  def solve("x" <> rest, stack, acc) do
    stack = stack_fox(["x" | stack])
    solve(rest, stack, acc)
  end
  def solve(<<_::utf8>> <> rest, stack, acc) do
    # stackの文字数をaccに積んで、リセットする
    acc = acc + 1 + length(stack)
    solve(rest, [], acc)
  end

  def stack_fox(["x", "o", "f" | tail]), do: stack_fox(tail)
  def stack_fox(tail), do: tail

end
