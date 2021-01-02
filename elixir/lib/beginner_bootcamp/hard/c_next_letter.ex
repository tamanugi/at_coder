defmodule NextLetter.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  @a_char 97

  def main() do
    s = IO.read(:line) |> String.trim() |> String.to_charlist()
    k = read_single()

    case solve(s, k, []) do
      {0, res} -> res |> Enum.reverse()
      {k, [h | t]} -> [h + k | t] |> Enum.reverse()
    end
    |> IO.puts()
  end

  def solve([], k, acc), do: {rem(k, 26), acc}
  def solve([ h | t], k, acc) do
    # a にできるならaにする
    {h, k} =
      if h != @a_char and k >= 123 - h do
        {@a_char, k - (123 - h)}
      else
        {h, k}
      end

    acc = [h | acc]

    solve(t, k, acc)
  end
end
