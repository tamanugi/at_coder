defmodule PalindromicMatrix.Main do
  require Integer

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [h, w] = read_array() |> Enum.sort()

    values =
      IO.read(:all)
      |> String.trim()
      |> String.split("\n")
      |> Enum.flat_map(fn s -> s |> String.split("") end)
      |> Enum.filter(fn s -> s != "" end)
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.sort(:desc)

    solve(values, h, w)
    |> IO.puts()
  end

  def solve(_, 1, 1), do: "Yes"
  def solve(values, 1, w) when rem(w, 2) == 0 do
    # 全部偶数個ならok
    values
    |> Enum.all?(fn i -> rem(i, 2) == 0 end)
    |> (fn
      true -> "Yes"
      false -> "No"
    end).()
  end
  def solve(values, 1, w) do
    case process(values, 2, div(w, 2), []) do
      [1] -> "Yes"
      _ -> "No"
    end
  end

  def solve(values, h, w) when rem(h, 2) == 0 and rem(w, 2) == 0 do
    # ｈとwが偶数の場合は全部4の倍数ならok
    values
    |> Enum.all?(fn i -> rem(i, 4) == 0 end)
    |> (fn
      true -> "Yes"
      false -> "No"
    end).()
  end

  def solve(values, h, w) when rem(h, 2) == 1 and rem(w, 2) == 1 do
    # hとwが奇数の場合
    c = div(h, 2) * div(w, 2)
    with rest when is_list(rest) <- process(values, 4, c, []),
      [1] <- process(rest, 2, div(h, 2) + div(w, 2), [])
    do
      "Yes"
    else
      _ -> "No"
    end
  end

  def solve(values, h, w) do
    [h, w] = [h, w] |> Enum.sort_by(fn i -> Integer.is_even(i) end)
    c = div(h, 2) * div(w, 2)
    with rest when is_list(rest) <- process(values, 4, c, []),
      [] <- process(rest, 2, div(w, 2), [])
    do
      "Yes"
    else
      _ -> "No"
    end
  end

  def process(rest, _, 0, acc), do: rest ++ acc
  def process([], _, _, _), do: :no
  def process([h | t], state, count, acc) do
    r = div(h, state)
    h = rem(h, state)
    count = count - r
    acc = if h == 0, do: acc, else: [h | acc]
    process(t, state, count, acc)
  end

end
