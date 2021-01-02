defmodule A106.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    solve(n)
    |> IO.puts()
  end

  def solve(n) do
    solve(n, 1)
  end

  def solve(n, b) do
    nn = n - pow(5, b)

    if nn >= 3 do
      case check3(nn, 0) do
        :no -> solve(n, b + 1)
        a -> "#{a} #{b}"
      end
    else
      -1
    end
  end

  def pow(_, 0), do: 1
  def pow(m, 2), do: m * m
  def pow(m, n) do
    case div_and_rem(n, 2) do
      {a, 0} -> pow(m, a) |> pow(2)
      {a, 1} -> (pow(m, a) |> pow(2)) * m
    end
  end
  def div_and_rem(m, n) do
    {div(m, n), rem(m, n)}
  end

  def check3(1, acc), do: acc
  def check3(3, acc), do: acc + 1
  def check3(n, acc) do
    if rem(n, 3) == 0 do
      check3(div(n, 3), acc + 1)
    else
      :no
    end
  end

  def test() do
    for _ <- 1..100 do
      a = 1..20 |> Enum.random()
      b = 1..20 |> Enum.random()

      n = (:math.pow(3, a) |> floor()) + (:math.pow(5, b) |> floor())
      res = solve(n)
      if res == "" do
        nil
      else
        IO.inspect({n, res})
      end
    end
    |> Enum.uniq()
    |> IO.inspect()

  end

end
