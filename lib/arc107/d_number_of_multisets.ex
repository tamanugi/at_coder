defmodule NumberOfMultisets.Main do

  @mod 998244353

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, k] = read_array()

    dp = %{{0, 0} => 1}
    :ets.new(:user_lookup, [:set, :protected, :named_table])
    :ets.insert(:user_lookup, {{0, 0}, 1})

    solve(0, n, n, dp)

    :ets.lookup(:user_lookup, {n, k})
    |> IO.inspect()
  end

  def solve(n, 0, keeper, dp) when n > keeper, do: dp
  def solve(n, 0, keeper, dp), do: solve(n + 1, keeper, keeper, dp)
  def solve(n, k, keeper, dp) do
    # v = Map.get(dp, {n - 1, k - 1} , 0)
    v =
      case :ets.lookup(:user_lookup, {n - 1, k - 1}) do
        [] -> 0
        [{_, v}] when is_integer(v) -> v
      end

    v =
      if 2 * k <= n do
       vv =
        case :ets.lookup(:user_lookup, {n, 2 * k}) do
          [] -> 0
          [{_, v}] when is_integer(v) -> v
        end
       v + vv
      else
        v
      end
      |> rem(@mod)

    # dp = Map.put(dp, {n, k}, v)
    # :ets.insert(:user_lookup, {{n, k}, v})

    solve(n, k - 1, keeper, dp)
  end

end
