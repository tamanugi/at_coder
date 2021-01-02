defmodule Arc110.B.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()
    s = IO.read(:line) |> String.trim()

    # sを1個含む形にするのに何個必要？
    unless n == 1  do
      case solve(s, 0) do
        n when n >= 0 ->  10_000_000_000 - (n - 1)
        _ -> 0
      end
    else
      case s do
        "1" -> 2 * 10_000_000_000
        "0" -> 10_000_000_000
      end
    end
    |> IO.puts()

  end

  def solve("110" <> rest, acc), do: solve(rest, acc + 1)
  def solve("0" <> rest, 0), do: solve(rest, 1)
  def solve("10" <> rest, 0), do: solve(rest, 1)
  def solve("", acc), do: acc
  def solve("1", acc), do: acc + 1
  def solve("11", acc), do: acc + 1
  def solve(_, _), do: -1

end
