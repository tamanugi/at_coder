defmodule ZigZag.Main do

  require Integer

  def main() do
    n = read_single()
    vs = read_array()

    solve(vs, n)
    |> IO.puts()
  end

  def solve(vs, n) do
    case vs |> Enum.uniq() |> length() do
      1 -> div(n, 2)
      _ ->
        {odd_acc, even_acc} = count(vs, 1, %{}, %{})

        os = odd_acc |> Map.to_list() |> Enum.sort_by(fn {_, c} -> c end, :desc) |> Enum.take(2)
        es = even_acc |> Map.to_list() |> Enum.sort_by(fn {_, c} -> c end, :desc) |> Enum.take(2)

        {on, oc} = Enum.at(os, 0, {0, 0})
        {en, ec} = Enum.at(es, 0, {0, 0})

        cond do
          on == en and oc == ec ->
            {_, ooc} = Enum.at(os, 1, {0, 0})
            {_, eec} = Enum.at(es, 1, {0, 0})
            n - max(oc, ec) - max(ooc, eec)
          on != en -> n - oc - ec
        end
    end
  end


  def count([], _, odd_acc, even_acc), do: {odd_acc, even_acc}
  def count([h | t], i, odd_acc, even_acc) do
    if Integer.is_odd(i) do
      count(t, i + 1, Map.update(odd_acc, h, 1, &( &1 + 1)), even_acc)
    else
      count(t, i + 1, odd_acc, Map.update(even_acc, h, 1, &( &1 + 1)))
    end
  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_map() do
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> read_map(0, %{})
  end

  def read_map([], _, acc), do: acc
  def read_map([h|t], i, acc) do
    acc = Map.put(acc, i, String.to_integer(h))
    read_map(t, i + 1, acc)
  end

  def test() do
    n = 100000
    steps = (for _ <- 1..n, do: (:rand.uniform * 1000 |> floor) )
    {time, _} = :timer.tc(ZigZag.Main, :solve, [steps, n])
    IO.inspect(time)
  end

end
