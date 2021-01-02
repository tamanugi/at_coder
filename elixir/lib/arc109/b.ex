defmodule Arc109.B.Main do
    def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()
    res = b_search(1, n+1, n+1)

    (n - res + 1)
    |> IO.puts()
  end

  def b_search(l, r, target)  do
    l_s = 1..l |> Enum.sum()
    r_s = 1..r |> Enum.sum()
    m = div(r + l, 2)
    m_s = 1..m |> Enum.sum()
    cond do
      l_s == target -> l
      r_s == target -> r
      m_s == target -> m
      l == r -> l
      r - l == 1 -> if r_s < target, do: r, else: l
      l_s < target and target < m_s -> b_search(l, m, target)
      m_s < target and target < r_s -> b_search(m, r, target)
    end
  end

end
