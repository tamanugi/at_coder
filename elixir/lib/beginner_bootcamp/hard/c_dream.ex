defmodule Dream.Main do

  def main() do
    IO.read(:line)
    |> String.trim()
    |> String.reverse()
    |> solve()
    |> IO.puts()
  end

  ~w(dream dreamer erase eraser)
  |> Enum.map(&String.reverse/1)
  |> Enum.each(fn s ->
    def solve(unquote(s) <> rest), do: solve(rest)
  end)

  def solve(""), do: "YES"
  def solve(_), do: "NO"
end
