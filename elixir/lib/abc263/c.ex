defmodule Abc263.C.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, m] = read_array()
    solve(n, m, [], 0)
  end

  def solve(0, _, ans, _), do: IO.puts(Enum.join(ans , " "))
  def solve(n, m, ans, i) do
    for ii <- i+1..(m - n + 1) do
      ans = ans ++ [ii]
      solve(n - 1, m, ans, ii)
    end
  end
end
