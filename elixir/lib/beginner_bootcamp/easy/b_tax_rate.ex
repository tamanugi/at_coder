defmodule TaxRate.Main do
  def read_single() do
    IO.read(:line) |> String.trim() |> String.to_integer()
  end

  def main() do
    n = read_single()

    with s <- (n / 1.08) |> ceil(),
      ^n <- floor(s * 1.08)
    do
      s
    else
      _ -> ":("
    end
    |> IO.puts()

  end

end
