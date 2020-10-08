defmodule Abc049C.Main do
  def main() do
    IO.read(:line)
    |> String.trim()
    |> solve()
    |> IO.puts
  end

  def solve("dream" <> tail) do
    case tail do
      "eraser" <> t -> solve(t)
      "erase" <> t -> solve(t)
      "ererase" <> t -> solve("erase" <> t)
      "er"  <> t ->
        case t do
          "e" <> tt -> solve("e" <> tt)
          _ -> solve(t)
        end
      _ -> solve(tail)
    end
  end

  def solve("eraser" <> tail), do: solve(tail)
  def solve("erase" <> tail), do: solve(tail)
  def solve(""), do: "YES"
  def solve(_), do: "NO"

  def test() do
    "erasedream" |> IO.inspect(label: "input") |> solve() |> IO.inspect(label: "expect yes")
    "dreamerase" |> IO.inspect(label: "input") |> solve() |> IO.inspect(label: "expect yes")
    "dreamererasereraseeraserdreamereraseraser" |> IO.inspect(label: "input") |> solve() |> IO.inspect(label: "expect yes")

    1..1000
    |> Enum.map(fn i ->
      case rem(i, 4) do
        0 -> "dream"
        1 -> "eraser"
        2 -> "erase"
        3 -> "dreamer"
      end
    end)
    |> Enum.join("")
    |> IO.inspect()
    |> solve()
    |> IO.inspect()
  end
end
