defmodule ABSubstrings.Main do

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  @spec main :: :ok
  def main() do
    _ = read_single()

    inputs =
       IO.binstream(:stdio, :line)
      |> Stream.map(&String.trim/1)
      |> Enum.to_list()

    # ABが入っている数をカウントする
    acc =
      inputs
      |> Enum.map(fn s -> String.split(s, "AB") |> Enum.count() |> Kernel.-(1) end)
      |> Enum.sum()

    # B-X, X-A, B-A をカウントする
    {bx, xa, ba} =
      inputs
      |> Enum.reduce({0, 0, 0}, fn s, {bx, xa, ba} ->
        case {s, String.reverse(s)} do
          {"B" <> _, "A" <> _} -> {bx, xa, ba + 1}
          {"B" <> _,  _} -> {bx + 1, xa, ba}
          {_, "A" <> _} -> {bx, xa + 1, ba}
          _ -> {bx, xa, ba}
        end
      end)

    case {bx, xa, ba} do
      {0, 0, ba} when ba > 0 -> (ba - 1) + acc
      {bx, xa, ba} when bx == 0 or xa == 0 -> ba + acc
      {bx, xa, ba} -> min(bx, xa) + ba + acc
    end
    |> IO.puts()
  end

end
