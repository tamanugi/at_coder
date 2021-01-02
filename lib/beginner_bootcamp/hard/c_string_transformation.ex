defmodule StringTransformation.Main do

  def main() do
    s = IO.read(:line) |> String.trim |> String.codepoints()
    t = IO.read(:line) |> String.trim |> String.codepoints()

    Enum.zip(s, t)
    |> Enum.with_index()
    |> solve(%{}, %{})
    |> IO.puts()
  end

  def solve([], _smap, _tmap), do: "Yes"
  def solve([{{s, t}, i} | rest], smap, tmap) do
    # 前回の出現位置
    cond do
      Map.get(smap, s, nil) == Map.get(tmap, t, nil) ->
        smap = Map.put(smap, s, i)
        tmap = Map.put(tmap, t, i)

        solve(rest, smap, tmap)
      true -> "No"
    end

  end

end
