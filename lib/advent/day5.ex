defmodule Advent.Day5 do

  def part1(), do: (for p <- (Advent.day(5) |> String.split("\n")) do
    find_seat(p) end) |> Enum.sort() |> Enum.reverse() |> hd

  def part2() do
    ids = (for p <- (Advent.day(5) |> String.split("\n")), do: find_seat(p)) |> Enum.sort()
    (for row <- 0..127,
        col <- 0..7,
        !(id(row, col) in ids) and (id(row, col)-1 in ids) and (id(row, col)+1 in ids),
        do: id(row, col)) |> hd
  end

  def id(row, col), do: row * 8 + col

  def find_seat(boarding_pass) when is_binary(boarding_pass), do:
    find_seat(String.graphemes(boarding_pass) ++ [:end], {0, 127}, {0, 7})

  def find_seat(boarding_pass, {xmin, xmax}, {ymin, ymax}) do
    [letter | rest] = boarding_pass
    xd = xmin+round((xmax-xmin)/2)
    yd = ymin+round((ymax-ymin)/2)
    case letter do
      "F" -> find_seat(rest, {xmin, xd}, {ymin, ymax})
      "B" -> find_seat(rest, {xd, xmax}, {ymin, ymax})
      "L" -> find_seat(rest, {xmin, xmax}, {ymin, yd})
      "R" -> find_seat(rest, {xmin, xmax}, {yd, ymax})
      _ -> id(xmin, ymin)
    end
  end

end