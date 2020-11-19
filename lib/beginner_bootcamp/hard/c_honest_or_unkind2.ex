defmodule HonestOrUnkind2.Main do
  use Bitwise

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()

    testimony = 1..n+1 |> testimony(%{})

    # bit全探索
    1..(1 <<< n)
    |> solve(testimony, 0)
    |> IO.puts()
  end

  def solve(n..n, _, acc), do: acc
  def solve(i..n, testimony, acc) do

    honests =
      i
      # bitにする
      |> Integer.digits(2)
      # bitから復元
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.filter(fn {v, _} -> v == 1 end)
      |> Enum.map(fn {_, i} -> i + 1 end)

    acc =
      case judge(honests, testimony) do
        :ok -> Enum.count(honests)
        :ng -> 0
      end
      |> max(acc)

    solve(i+1..n, testimony, acc)
  end

  def judge(honests, testimony) do
    stats =
      for i <- honests, into: %{}, do: {i, 1}

    judge(honests, testimony, stats)
  end
  def judge([], _, _), do: :ok
  def judge([h | t], testimony, stats) do
    res =
      Map.get(testimony, h, [])
      |> Enum.reduce_while(:ok, fn [person, hu], _ ->
        case Map.get(stats, person, 0) do
          ^hu ->
            # 証言と一致
            {:cont, :ok}

          _ ->
            # 証言と一致しない(矛盾)
            {:halt, :contradiction}
        end
      end)

    case res do
      :contradiction -> :ng
      :ok -> judge(t, testimony, stats)
    end
  end

  def testimony(n..n, acc), do: acc
  def testimony(i..n, acc) do
    a = read_single()

    acc =
      unless a == 0 do
        inputs =
          for _ <- 1..a do
            read_array()
          end

        Map.put(acc, i, inputs)
      else
        acc
      end
    testimony(i+1..n, acc)
  end

end
