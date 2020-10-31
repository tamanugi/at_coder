defmodule Minesweeper.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [h, w] = read_array()

    board =
      IO.read(:all)
      |> String.split("\n")
      |> Enum.flat_map(&String.split(&1, ""))
      |> Enum.filter(&(String.length(&1) > 0))

    0..(h*w-1)
    |> Enum.reduce(board, fn i, acc ->
      case Enum.at(acc, i) do
        "." ->
          # 周りの8マスを確認する
          c = around(board, i, h, w)
          List.update_at(acc, i, fn _ -> c end)
        "#" -> acc
      end
    end)
    |> Enum.chunk_every(w)
    |> Enum.map(fn s -> Enum.join(s) end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  def around(board, i, h, w) do
    {y, x} = {div(i, w), rem(i, w)}

    (for dy <- -1..1, dx <- -1..1, {dy, dx} != {0, 0}, do: {dy, dx})
    |> Enum.map(fn {dy, dx} -> {y + dy, x + dx} end)
    |> Enum.reject(fn {dy, dx} -> dy < 0 or dx < 0 or dy >= h or dx >= w end)
    # |> IO.inspect(label: "#{i}")
    |> Enum.map(fn {dy, dx} -> dy * w + dx end)
    # |> IO.inspect()
    |> Enum.map(fn ii -> Enum.at(board, ii) end)
    |> Enum.filter(fn s -> s == "#" end)
    |> Enum.count()
  end

end
