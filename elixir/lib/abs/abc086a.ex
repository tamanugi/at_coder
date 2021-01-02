defmodule Abc086A.Main do
  require Integer

  def main() do

    [a, b] = IO.read(:line) |> String.split(" ") |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)

    case {Integer.is_odd(a), Integer.is_odd(b)} do
      {true, true} -> "Odd"
      _ -> "Even"
    end
    |> IO.puts()

  end

end
