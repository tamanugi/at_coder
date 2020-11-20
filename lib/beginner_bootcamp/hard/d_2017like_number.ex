defmodule LikeNumber.Main do
  defmodule SieveOfEratosthenes do

    def run(n) do
      sqrt = :math.sqrt(n) |> floor()

      d = init_d(n)

      # 偶数を飛ばす
      Stream.iterate(13, &(&1 + 2))
      |> Stream.take_while(&(&1 <= sqrt))
      # 3, 5, 7, 11 の倍数は見ているので飛ばす
      |> Stream.reject(&(rem(&1, 3) == 0))
      |> Stream.reject(&(rem(&1, 5) == 0))
      |> Stream.reject(&(rem(&1, 7) == 0))
      |> Stream.reject(&(rem(&1, 11) == 0))
      |> Enum.to_list()
      |> process(n, d)
    end

    def process([], _, d), do: d
    def process([i | t], n, d) do
      d =
        case d[i] do
          ^i ->
            d = Map.put(d, i, i)

            dd =
              Stream.iterate(2 * i, &(&1 + i))
              |> Stream.take_while(&(&1 <= n))
              # すでに因数が格納されているものは飛ばす
              |> Stream.filter(fn j -> d[j] == j end)
              |> Stream.map(fn j -> {j, i} end)
              |> Enum.to_list()
              |> Map.new()

            Map.merge(d, dd)

          _ ->  d
      end

      process(t, n, d)
    end

    def init_d(n) do
      for i <- 1..n do
        cond do
          rem(i, 2) == 0 -> {i, 2}
          rem(i, 3) == 0 -> {i, 3}
          rem(i, 5) == 0 -> {i, 5}
          rem(i, 7) == 0 -> {i, 7}
          rem(i, 11) == 0 -> {i, 11}
          true -> {i, i}
        end
      end
      |> Map.new()
    end

    def test() do
      n = 1000_000
      {time, r} = :timer.tc(SieveOfEratosthenes, :run, [n])
      IO.inspect(r)
      IO.inspect(time)
    end

  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()
  end

  def main() do
    _ = read_single()
    lrs = read_multi_array()

    # 10^5 以下の 2017に似た奇数を予めピックアップする
    d = SieveOfEratosthenes.run(100_000)

    likes =
      # 1は素数じゃないので3から
      Stream.iterate(3, &(&1 + 2))
      |> Stream.take_while(&(&1 <= 100_000))
      # 素数だけ
      |> Stream.filter(fn i -> d[i] == i end)
      # (i+1)/2も素数か
      |> Stream.filter(fn i ->
        j = div(i + 1, 2)
        d[j] == j
      end)
      |> Enum.to_list()

    # それぞれのiでの出現回数を記録しておく
    count_map = prepare(1, likes, 0, %{})

    solve(lrs, count_map, [])
    |> IO.puts()
  end

  def prepare(i, _, _, acc) when i > 100_000, do: acc
  def prepare(2, [2 | t], pre, _), do: prepare(3, t, pre, %{1 => 0, 2 => 0})
  def prepare(i, [i | t], pre, acc) do
    pre = pre + 1
    acc = Map.put(acc, i, pre)
    prepare(i+1, t, pre, acc)
  end
  def prepare(i, likes, pre, acc) do
    acc = Map.put(acc, i, pre)
    prepare(i+1, likes, pre, acc)
  end

  def solve([], _, acc), do: acc |> Enum.reverse() |> Enum.join("\n")
  def solve([[l, r] | t], count_map, acc) do
    ll = Map.get(count_map, l - 1, 0)
    rr = count_map[r]

    solve(t, count_map, [rr - ll | acc])
  end

end
