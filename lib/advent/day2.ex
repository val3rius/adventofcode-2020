defmodule Advent.Day2 do

  def part1(input) do
    Advent.read_input(input)
      |> Enum.map(fn line -> Regex.named_captures(~r/(?<min>[0-9]+)-(?<max>[0-9]+)\ (?<letter>[a-z]{1})\:\ (?<pw>[a-z]*).*/, line) end)
      |> Enum.filter(fn map ->
        {intMin, _} = Integer.parse(map["min"])
        {intMax, _} = Integer.parse(map["max"])
        occ = occurrences(map["letter"], map["pw"])
        intMax >= occ && occ >= intMin end)
      |> length
  end

  def part2(input) do
    Advent.read_input(input)
      |> Enum.map(fn line -> Regex.named_captures(~r/(?<pos1>[0-9]+)-(?<pos2>[0-9]+)\ (?<letter>[a-z]{1})\:\ (?<pw>[a-z]*).*/, line) end)
      |> Enum.filter(fn map ->
        {pos1, _} = Integer.parse(map["pos1"])
        {pos2, _} = Integer.parse(map["pos2"])
        firstMatches = String.at(map["pw"], pos1-1) == map["letter"]
        secondMatches = String.at(map["pw"], pos2-1) == map["letter"]
        firstMatches != secondMatches
        end)
      |> length
  end

  def occurrences(letter, word) do
    case word do
      nil -> 0
      w -> w |> String.graphemes() |> Enum.filter(fn chr -> chr == letter end) |> length
    end
  end
end