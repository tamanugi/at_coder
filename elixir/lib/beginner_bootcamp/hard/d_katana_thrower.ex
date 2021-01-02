defmodule KatanaThrower.Main do

  def read_array() do
    IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def read_multi_array() do
    IO.binstream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&(String.split(&1, " ") |> Enum.map(fn i -> String.to_integer(i) end)))
    |> Enum.to_list()
  end

  def main() do
    [_, hp] = read_array()

    ks = read_multi_array()

    # 通常攻撃で一番高いもの
    [na, _] = ks |> Enum.max_by(fn [n, _] -> n end)

    # 投攻撃で通常より攻撃力が高いもの
    as =
      ks
      |> Enum.filter(fn [_, a] -> a > na end)
      |> Enum.map(fn [_, a] -> a end)
      |> Enum.sort(:desc)

    {hp, i} = throw_attack(as, hp)

    if hp > 0 do
      case div_and_rem(hp, na) do
        {ii, 0} -> ii + i
        {ii, _} -> ii + 1 + i
      end
    else
      i
    end
    |> IO.puts()
  end

  def throw_attack(_, _, i \\ 0)
  def throw_attack(_, hp, i) when hp <= 0, do: {hp, i}
  def throw_attack([], hp, i), do: {hp, i}
  def throw_attack([h | t], hp, i) do
    throw_attack(t, hp - h, i + 1)
  end

  def div_and_rem(m, n) do
    {div(m, n), rem(m, n)}
  end

end
