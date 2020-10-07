defmodule Abc085C.Main do

  def main() do
    [x, y] = IO.read(:line) |> String.split(" ") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)

    solve(x, y)
    |> Enum.join(" ")
    |> IO.puts()
  end

  def solve(x, y) do

    case div(y, 1000) do
      c3max when c3max == x -> [0, 0, c3max]
      c3max when c3max < x -> [-1, -1, -1]
      c3max ->
        dx = c3max - x

        # dx を 9 と 4 で組み立てられるか考える
        div(dx, 9)..0
        |> Enum.reduce_while({-1, -1}, fn c1, _ ->
          dd = dx - (9 * c1)
          case div_and_rem(dd, 4) do
            {c2, 0} ->
              c3 = c3max - (c1 * 10) - (c2 * 5)
              if c3 >= 0 do
                {:halt, [c1, c2, c3]}
              else
                {:cont, [-1, -1, -1]}
              end
            _ -> {:cont, [-1, -1, -1]}
          end
        end)
      end

  end

  def div_and_rem(_, 0), do: {0, 0}
  def div_and_rem(a, b), do: {div(a, b), rem(a, b)}

  def test() do
    1..100
    |> Enum.reduce_while([], fn _, _ ->
      c1 = 1..1000 |> Enum.random()
      c2 = 1..1000 |> Enum.random()
      c3 = 1..1000 |> Enum.random()

      x = c1 + c2 + c3
      y = c1 * 10000 + c2 * 5000 + c3 * 1000
      IO.inspect([c1, c2, c3, c1 + c2 + c3, c1 * 10000 + c2 * 5000 + c3 * 1000], label: "input")

      case solve(x, y) |> IO.inspect(label: "output") do
        [o1, o2, o3] when o1 + o2 + o3 == o1 + o2 + o3 and o1 * 10000 + o2 * 5000 + o3 * 1000 == y ->
          {:cont, :ok}
        [-1, -1, -1] ->
          {:halt, :ok}
        [o1, o2, o3] ->
          IO.inspect([o1 + o2 + o3, c1 + c2 + c3, c1 * 10000 + c2 * 5000 + c3 * 1000], label: "ERROR!")
          {:halt, :ng}
      end

    end)
  end

end
