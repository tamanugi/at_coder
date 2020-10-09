defmodule Abc176D.Main do

  def main() do
    [h, w] = IO.read(:line) |> str_to_list()
    [ch, cw] = IO.read(:line) |> str_to_list()
    [dh, dw] = IO.read(:line) |> str_to_list()

    maze =
      1..h
      |> Enum.flat_map(fn _ ->
        IO.read(:line) |> str_to_maze()
      end)

    solve(maze, h, w, {ch - 1, cw - 1}, {dh - 1, dw - 1})
  end

  def solve(maze, h, w, start, goal) do

    # インデックス変換メソッド
    mi = mifn(h, w)

    # コストの配列を作成する
    # スタート地点のコストは0
    costs = (for _ <- 1..h, _ <- 1..w, do: nil) |> List.update_at(mi.(start), fn _ -> 0 end)

    # キュー
    q = :queue.in(start, :queue.new())

    process(q, costs, maze, mi, h, w)
    |> Enum.at(mi.(goal))
    |> output()
    |> IO.puts
  end

  def output(nil), do: -1
  def output(c), do: c

  def process({[], []}, costs, _, _, _, _), do: costs
  def process(q, costs, maze, mi, h, w) do
    {{:value, {hi, wi}}, q} = :queue.out(q)
    IO.puts("#{hi} #{wi}")

    # 現在位置のコスト
    c = Enum.at(costs, mi.({hi, wi}))

    # 上下左右
    {costs, q} =
      [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
      |> Enum.map(fn {y, x} -> {hi + y, wi + x} end)
      |> Enum.filter(fn {y, x} -> y >= 0 and y < h and x >= 0 and x < w end)
      |> Enum.reduce({costs, q}, fn point, {acc_costs, acc_q} ->
        cc = Enum.at(acc_costs, mi.(point))

        with true <- cc > c,
          "." <- Enum.at(maze, mi.(point))
        do
            # 今キューに入っていたら削除した上で一番最初に追加
            acc_q = :queue.filter(fn v -> v != point end, acc_q)
            acc_q = :queue.in_r(point, acc_q)
            {List.update_at(acc_costs, mi.(point), fn _ -> c end), acc_q}
        else
          _ -> {acc_costs, acc_q}
        end
      end)

    # ワープ
    {costs, q} =
      (for i <- -2..2, j <- -2..2, abs(i) + abs(j) >= 2, do: {i, j})
      |> Enum.map(fn {y, x} -> {hi + y, wi + x} end)
      |> Enum.filter(fn {y, x} -> y >= 0 and y < h and x >= 0 and x < w end)
      |> Enum.reduce({costs, q}, fn point, {acc_costs, acc_q} ->
        cc = Enum.at(acc_costs, mi.(point))

        with true <- cc > c + 1,
          "." <- Enum.at(maze, mi.(point))
        do
          # キューになければ追加
          acc_q = unless :queue.member(point, acc_q), do: :queue.in(point, acc_q), else: acc_q
          {List.update_at(acc_costs, mi.(point), fn _ -> c + 1 end), acc_q}
        else
          _  -> {acc_costs, acc_q}
        end
      end)

    process(q, costs, maze, mi, h, w)
  end

  def mifn(h, _) do
    fn
      {i, j} -> i * h + j
    end
  end

  def str_to_maze(str) do
    str
    |> String.trim()
    |> String.split("")
    |> Enum.filter(&(String.length(&1) > 0))
  end
  def str_to_list(s), do: s |> String.split(" ") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)
end
