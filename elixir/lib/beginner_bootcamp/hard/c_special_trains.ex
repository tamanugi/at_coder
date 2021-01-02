defmodule SpecialTrains.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()
  end

  def main do
    _ = read_single()

    read_multi_array()
    |> solve([])
    |> IO.puts()
  end

  def solve([], acc), do: [0 | acc] |> Enum.reverse() |> Enum.join("\n")
  def solve([[c, s, _f] | t], acc) do
    time = calc(t, c + s)
    solve(t, [time | acc])
  end

  def calc([], pre), do: pre
  def calc([[nc, ns, nf] | t], pre) do
    if pre < ns do
      # 始発前
      calc(t, nc + ns)
    else
      # 始発が行ったあと
      w =
        case rem(pre - ns, nf) do
          0 -> 0
          i -> nf - i
        end
      calc(t, pre + w + nc)
    end
  end

end
