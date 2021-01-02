defmodule AtCoder176B do
  def main() do
    IO.read(:line)
    |> String.trim()
    # |> String.split(" ")
    # |> Enum.map(&String.to_integer/1)
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  ## Examples

      iex> AtCoder176B.solve("123456789")
      "Yes"

      iex> AtCoder176B.solve("31415926535897932384626433832795028841971693993751058209749445923078164062862089986280")
      "No"

  """
  def solve(n) do
    r =
      n
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce(fn e, acc -> e + acc end)
      |> rem(9)

    case r do
      0 -> "Yes"
      _ -> "No"
    end
  end
end
