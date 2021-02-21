defmodule Abc192.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    s = IO.read(:line) |> String.trim() |> String.codepoints()

      s
      |> Enum.with_index(1)
      |> Enum.reduce_while("Yes", fn {c, i}, _ ->
        check =
          case rem(i, 2) do
            0 ->
              # 偶数は大文字
              c == String.upcase(c)
            1 ->
              # 奇数は小文字
              c == String.downcase(c)
          end

        if check, do: {:cont, "Yes"}, else: {:halt, "No"}
      end)
      |> IO.puts()

  end
end
