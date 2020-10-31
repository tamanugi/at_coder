defmodule AtCoder176C do
  def main() do
    IO.read(:line)

    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  ## Examples

      iex> AtCoder176C.solve([2, 1, 5, 4, 3])
      4

      iex> AtCoder176C.solve([3, 3, 3, 3, 3])
      0

  """
  def solve(n) do
    {_, r} =
      n
      |> Enum.reduce({0, 0}, fn e, {prev, acc} ->
        case prev > e do
          true ->
            acc = acc + (prev - e)
            {prev, acc}

          false ->
            {e, acc}
        end
      end)

    r
  end
end
