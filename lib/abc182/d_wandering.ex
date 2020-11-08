defmodule Wandering.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    n = read_single()
    as = read_array()

    m = as |> Enum.with_index(1) |> Enum.map(fn {v, i} -> {i, v} end) |> Map.new()

    # それぞれ時点での累積和
    sarray = sum_array(as, [])

    {c, idx} = sarray |> Enum.max_by(fn {v, _} -> v end)

    smap = sarray |> Enum.map(fn {v, i} -> {i, v} end) |> Map.new()

    unless c <= 0 do
      # idx　で止めたとき
      res1 =
        1..idx
        |> Enum.reduce(0, fn i, acc ->
           acc + (idx + 1 - i) * m[i]
        end)

      # もう一週したとき
      res2 =
        res1 + m[idx+1] + smap[idx]

      if res1 >= res2 do
        res1
      else
        sss = smap[idx]
        {_, stop} =  sarray |> Enum.find({0, n}, fn {v, i} -> v < -1 * sss and i > idx end)

        # 回れるだけ回ったほうがいい
        1..stop
        |> Enum.reduce(0, fn i, acc ->
          if i <= idx do
            acc + (stop + 1 - i) * m[i]
          else
            # 最後の週のidxより後は進まない
            acc + (stop - i) * m[i]
          end
        end)
      end
    else
      0
    end
    |> IO.puts()
  end

  def sum_array([], acc), do: acc |> Enum.reverse() |> Enum.with_index(1)
  def sum_array([h | t], []), do: sum_array(t, [h])
  def sum_array([h | t], [p | _] = acc), do: sum_array(t, [p + h | acc])

end
