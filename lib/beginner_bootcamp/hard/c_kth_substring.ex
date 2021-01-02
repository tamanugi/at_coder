defmodule KthSubstring.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    s = IO.read(:line) |> String.trim()
    k = read_single()

    s
    |> chunk(k, [])
    |> Enum.sort()
    |> Enum.uniq()
    |> Enum.take(k * 10)
    |> solve([])
    |> Enum.sort()
    |> Enum.uniq()
    |> Enum.at(k - 1)
    |> IO.puts()
  end

  def chunk("", _, acc), do: acc
  def chunk(<<c::utf8>> <> rest, k, acc) do
    tail = rest |> String.slice(0, k - 1) |> String.codepoints()
    chunk(rest, k, [[<<c::utf8>> | tail] | acc])
  end

  def solve([], acc), do: acc
  def solve([h | t], acc) do
    res =
      h
      |> Enum.reduce([], fn
        s, [h | _]= acc -> [h <> s | acc]
        s, [] -> [s]
      end)

    solve(t, res ++ acc)
  end

end
