defmodule Abc085C.Main do

  def main() do
    [x, y] = IO.read(:line) |> String.split(" ") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)

    solve(x, y)
    |> IO.inspect()
  end

  def solve(x, y) do

    case div_and_rem(y, 10000) do
      {c1, 0} when c1 == x -> {c1, 0, 0}
      {c1, r} ->
        case div_and_rem(r, 5000) do
          {c2, 0} when c1 + c2 == x -> {c1, c2, 0}
          {c2, rr} ->
            case div_and_rem(rr, 1000) do
              {c3, 0} when c1 + c2 + c3 == x -> {c1, c2, c3}
              {_, rrr} when rrr > 0 -> {-1, -1, -1}
              {c3, _} when c1 + c2 + c3 > x -> {-1, -1, -1}
              {c3, _} ->

                dx = x - (c1 + c2 + c3)
                {:todo, dx, c1, c2, c3}
            end
        end

    end

  end

  def div_and_rem(_, 0), do: {0, 0}
  def div_and_rem(a, b), do: {div(a, b), rem(a, b)}

end
