defmodule TransformableTeacher.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, m] = read_array()
    hs = read_array() |> Enum.sort()
    ws = read_array() |> Enum.sort()

    sum1 = make_sum(hs, 1, 0, 0, %{0 => 0})
    [_ | rest] = hs
    l = map_size(sum1)
    sum2 = make_sum(Enum.reverse(rest), 0, 0, l - 2, %{l - 1 => 0})

    # solve(hs, ws, 0, [], [])
  end

  def make_sum([h1, h2 | t], i, s, len, acc) do
    s = s + abs(h2 - h1)
    acc = Map.put(acc, abs(len - i), s)
    make_sum(t, i + 1, s, len, acc)
  end
  def make_sum(_, _, _, _, acc), do: acc

  def solve([t], ws, i, acc, acc2) do
    IO.inspect(Enum.reverse(acc))
    IO.inspect(Enum.reverse(acc2))
  end
  def solve([h1, h2 | t], ws, i, acc, acc2) do
    acc = [{i, h2 - h1} | acc]
    acc2 = [{i, abs(teacher(ws, h1))} | acc2]
    # 選択肢1
    # acc = acc + h2 - h1
    # 選択肢2
    # h3 - h2 +  teacher(ws, h1)
    solve([h2 | t], ws, i + 1, acc, acc2)
  end

  def teacher(ws, t) do
    Enum.map(ws, fn w -> abs(w - t) end) |> Enum.min()
  end

end
