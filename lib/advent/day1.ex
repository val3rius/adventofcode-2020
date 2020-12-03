defmodule Advent.Day1 do

  def part1(input) do
    ints = Advent.read_input(input)
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(fn {val, res} -> val end)

    [valids] = comb(2, ints)
      |> Enum.filter(fn list -> Enum.reduce(list, fn x,acc -> x+acc end) == 2020 end)

    Enum.reduce(valids, fn x,acc -> x*acc end)

  end

  def part2(input) do
    ints = Advent.read_input(input)
           |> Enum.map(&Integer.parse/1)
           |> Enum.map(fn {val, res} -> val end)

    [valids] = comb(3, ints)
               |> Enum.filter(fn list -> Enum.reduce(list, fn x,acc -> x+acc end) == 2020 end)

    Enum.reduce(valids, fn x,acc -> x*acc end)

  end

  # Stolen from https://rosettacode.org/wiki/Combinations#Elixir
  def comb(0, _), do: [[]]
  def comb(_, []), do: []
  def comb(m, [h|t]) do
    (for l <- comb(m-1, t), do: [h|l]) ++ comb(m, t)
  end

end