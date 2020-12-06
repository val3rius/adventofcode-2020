defmodule Advent.Day6 do

  def part1(input) do
    (for g <- Advent.read_input_no_split(input) |> String.split("\n\n") do
      String.replace(g, "\n", "")
      |> String.graphemes()
      |> Enum.sort()
      |> Enum.uniq()
      |> length
   end)
    |> Enum.sum
 end

  def part2(input) do
    (for g <- Advent.read_input_no_split(input) |> String.split("\n\n") do
       String.replace(g, "\n", "")
        |> String.graphemes()
        |> Enum.reduce(%{}, fn x,acc -> Map.update(acc, x, 1, &(&1+1)) end)
        |> Enum.filter(fn {k,v} -> v == (String.split(g, "\n") |> length) end)
        |> Enum.reduce(0, fn x,acc -> acc+1  end)
       end)
    |> Enum.sum
  end
end
