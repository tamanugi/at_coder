defmodule DubiousDocument2.Main do

  def main() do
    s = IO.read(:line) |> String.trim()
    ss = s |> String.split("") |> Enum.filter(&(String.length(&1) > 0)) |> Enum.with_index()
    t = IO.read(:line) |> String.trim()
    tt = t |> String.split("") |> Enum.filter(&(String.length(&1) > 0))

    t_size = length(tt)
    ss
    |> Enum.chunk_every(t_size, 1, :discard)
    |> Enum.filter(fn sub ->
      Enum.zip(sub, tt) |> Enum.all?(fn {{c, _}, t} -> c == "?" or c == t end)
    end)
    |> Enum.map(fn [{_, h} | _] ->
      replace_at(s, h, t)
      |> String.replace("?", "a")
    end)
    |> Enum.sort()
    |> Enum.at(0, "UNRESTORABLE")
    |> IO.puts()

  end

  def replace_at(s, start_index, replaced) do
    {h, t} = String.split_at(s, start_index)
    {_, rest} = String.split_at(t, String.length(replaced))
    h <> replaced <> rest
  end

end
