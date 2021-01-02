defmodule IrohaObsession.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def main() do
    [n, _] = read_array()
    ds = read_array()

    Stream.iterate(n, &(&1 + 1))
    |> Stream.reject(fn i -> Integer.digits(i) |> Enum.any?(fn x -> Enum.member?(ds, x) end) end)
    |> Enum.take(1)
    |> List.first()
    |> IO.puts()
  end

end
