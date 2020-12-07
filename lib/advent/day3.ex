defmodule Advent.Day3 do

  def part1() do
    Advent.day(3) |> String.split("\n") |> solve(3, 1)
  end

  def part2() do
    [
      {1,1},
      {3,1},
      {5,1},
      {7,1},
      {1,2}
    ]
      |> Enum.map(fn x -> solve((Advent.day(3) |> String.split("\n")), elem(x,0), elem(x,1)) end)
      |> Enum.reduce(1, fn x,acc -> x * acc end)
  end

  def solve(input, right, down) do
    input |> Enum.reduce(%{pos: 1, trees: 0, index: 0}, fn x,acc ->
      case rem(acc[:index], down) != 0 do
        true ->
          acc = %{pos: acc[:pos], trees: acc[:trees], index: acc[:index]+1}
        false ->
          case has_tree(x, acc[:pos]) do
            true ->
              acc = %{pos: next(acc[:pos], right), trees: acc[:trees]+1, index: acc[:index]+1}
            false ->
              acc = %{pos: next(acc[:pos], right), trees: acc[:trees], index: acc[:index]+1}
          end
      end
    end) |> Access.get(:trees)
  end


  def has_tree(row, pos) do
    case row do
      nil -> false
      r -> r |> String.graphemes() |> Enum.at(pos-1) == "#"
    end
  end

  def next(pos, distance) do
    case pos+distance > 31 do
      true ->
        pos+distance-31
      false -> pos+distance
    end
  end

end