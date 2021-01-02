defmodule GettingDifference.Main do
  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [_, k] = read_array()
    as = read_array()

    max = Enum.max(as)

    if max >= k do
      gcd = gcd(as)
      cond do
        rem(k, gcd) == 0 -> "POSSIBLE"
        true -> "IMPOSSIBLE"
      end
    else
      "IMPOSSIBLE"
    end
    |> IO.puts()

  end

  def gcd(nums) do
    min = Enum.min(nums)
    nums = nums
    |> Enum.map(fn i -> rem(i, min) end)
    |> Enum.uniq()
    |> Enum.filter(fn i -> i > 0 end)

    case nums do
      [] -> min
      nums -> gcd(nums)
    end
  end

end
