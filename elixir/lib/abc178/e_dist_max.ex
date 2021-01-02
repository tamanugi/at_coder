defmodule DistMax.Main do

  def main() do
    _ = read_single()
    xys = read_multi_array()

    solve(xys)
    |> IO.puts
  end

  def solve([[x, y] | t]) do
    u = x + y
    v = x - y
    solve(t, u, u, v, v)
  end
  def solve([], umin, umax, vmin, vmax), do: max(abs(umax - umin), abs(vmax - vmin))
  def solve([[x, y] | t], umin, umax, vmin, vmax) do
    u = x + y
    v = x - y

    umin = min(umin, u)
    umax = max(umax, u)
    vmin = min(vmin, v)
    vmax = max(vmax, v)

    solve(t, umin, umax, vmin, vmax)
  end

  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_map() do
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> read_map(0, %{})
  end

  def read_map([], _, acc), do: acc
  def read_map([h|t], i, acc) do
    acc = Map.put(acc, i, String.to_integer(h))
    read_map(t, i + 1, acc)
  end

  def read_multi_array() do
    IO.read(:all)
    |> String.split("\n")
    |> Enum.filter(fn s -> String.length(s) > 0 end)
    |> Enum.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
  end

  def test() do
    n = 100000
    steps = (for _ <- 1..n, do: [rand(1000), rand(1000)])
    {time, r} = :timer.tc(DistMax.Main, :solve, [steps])
    IO.inspect(r)
    IO.inspect(time)
  end

  defp rand(m) do
    (:rand.uniform * m)
    |> floor
  end

end
