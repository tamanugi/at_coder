defmodule LiningUp.Main do
  @mod 1000_000_000 + 7

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()
    as = read_array()


    m = as |> Enum.frequencies()
    case check(n - 1, m) do
      :ok ->
        pow(2, div(n, 2))
        |> rem(@mod)
      :ng -> 0
    end
    |> IO.puts()
  end

  def check(n, _map) when n < 0, do: :ok
  def check(0, map) do
    case map[0] do
      1 -> :ok
      _ -> :ng
    end
  end
  def check(i, map) do
    case map[i] do
      2 -> check(i - 2, map)
      _ -> :ng
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

end
