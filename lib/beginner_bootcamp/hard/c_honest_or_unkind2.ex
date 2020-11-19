defmodule HonestOrUnkind2.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()

    testimony = 1..n+1 |> testimony(%{}) |> IO.inspect()

    testimony
    |> Map.values()
    |> List.flatten()
    |> Enum.chunk_every(2)
    |> Enum.reduce(%{}, fn [i, s], acc ->
      Map.update(acc, i, [s], fn ss -> [s | ss] end)
    end)
    |> IO.inspect()

    1..n+1
    |> solve(testimony, 0)
    |> IO.puts()
  end

  def solve(n..n, _, acc), do: acc
  def solve(i..n, testimony, acc) do
    IO.puts("if #{i} is honest")

    acc =
      if Map.has_key?(testimony, i) do
        case judge([i], testimony, %{i => 1}) do
          0 -> acc
          stats ->
            IO.inspect(stats)
            1..n-1
            |> Enum.map(fn j -> Map.get(stats, j, 0) end)
            |> Enum.filter(&(&1 == 1))
            |> Enum.sum()
            |> IO.inspect()
            |> max(acc)
        end
      else
        acc
      end

    solve(i+1..n, testimony, acc)
  end

  def judge([], _, stats), do: stats
  def judge([h | t], testimony, stats) do
    s = stats[h]
    IO.inspect(stats)

    if s == 1 do
      # 正直者の証言は信用する
      res =
        Map.get(testimony, h, [])
        |> Enum.reduce_while({t, stats}, fn [person, hu], {q, stats} ->
          case stats[person] do
            nil ->
              # まだ未確定
              {:cont, {[person|q], Map.put(stats, person, hu)}}
            ^hu ->
              # 過去の証言と一致
              {:cont, {q, stats}}
            hoge ->
              IO.inspect("expect #{hoge} but #{hu}", label: "#{h} #{person}")
              # 過去の証言と一致しない(矛盾)
              {:halt, :contradiction}
          end
        end)

      case res do
        :contradiction -> 0
        {q, stats} ->
          judge(q, testimony, stats)
      end
    else
      judge(t, testimony, stats)
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
