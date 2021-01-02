defmodule StrawberryCakes.Main do

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.codepoints/1)
    |> Enum.to_list()
  end
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, _, _] = read_array()

    cake = read_multi_array()

    splith(cake)
    |> splitv()
    |> Enum.join("\n")
    |> IO.puts()
  end

  # 横にカットしていく
  # いちごが無い行はある行とセットにする
  def splith(_, tmp \\ 0, acc \\ [])
  def splith([], 0, acc), do: acc |> Enum.reverse()
  def splith([], tmp, [{h, c} | t]), do: splith([], 0, [ {h, c + tmp} | t])
  def splith([h | t], tmp, acc) do
    case h |> Enum.uniq() do
      ["."] ->
        splith(t, tmp + 1, acc)
      _ ->
        splith(t, 0, [{h, tmp} | acc])
    end
  end

  # 縦カット
  def splitv(_, g \\ 1, acc \\ [])
  def splitv([], _g, acc), do: acc |> Enum.reverse() |> List.flatten()
  def splitv([{row , c} | t], g, acc) do
    {g, s} = row |> splitv_process(g)
    sss = for _ <- 1..c+1, do: s
    splitv(t, g + 1, [sss | acc])
  end

  def splitv_process(_, g, pre \\ ".", acc \\ [])
  def splitv_process([], g, _pre, acc), do: {g - 1, acc |> Enum.reverse() |> Enum.join(" ")}
  def splitv_process(["." | t], g, ".", acc), do: splitv_process(t, g, ".", [g | acc])
  def splitv_process(["." | t], g, "#", acc), do: splitv_process(t, g, "#", [g - 1 | acc])
  def splitv_process(["#" | t], g, _, acc), do: splitv_process(t, g + 1, "#", [g | acc])

end
