defmodule Advent.Day4 do

  def part1(input) do
    batch = Advent.read_input_no_split(input)
    passports = String.split(batch, "\n\n")
      |> Enum.map(fn x -> String.replace(x, "\n", " ") end)
      |> Enum.map(fn x -> String.split(x, " ") end)
      |> Enum.map(fn x -> make_passport(x) end)
    (for p <- passports, has_valid_shape?(p), do: p) |> length
  end

  def part2(input) do
    batch = Advent.read_input_no_split(input)
    passports = String.split(batch, "\n\n")
                |> Enum.map(fn x -> String.replace(x, "\n", " ") end)
                |> Enum.map(fn x -> String.split(x, " ") end)
                |> Enum.map(fn x -> make_passport(x) end)
    (for p <- passports, has_valid_shape?(p), has_valid_values?(p), do: p) |> length
  end

  def make_passport(list), do:
    (for p <- list, do: [key, value] = String.split(p, ":"))
      |> Enum.reduce(%{}, fn [key, value], acc -> Map.put(acc, key, value) end)

  def has_valid_shape?(passport) when map_size(passport) == 8, do: true
  def has_valid_shape?(passport) when map_size(passport) == 7, do: passport["cid"] == nil
  def has_valid_shape?(passport), do: false

  def has_valid_values?(passport) do
    hgt = Regex.named_captures(~r/(?<val>\d+)(?<unit>cm|in)/, passport["hgt"])
    with true <- (String.to_integer(passport["byr"]) >= 1920 && String.to_integer(passport["byr"]) <= 2002),
      true <- (String.to_integer(passport["iyr"]) >= 2010 && String.to_integer(passport["iyr"]) <= 2020),
      true <- (String.to_integer(passport["eyr"]) >= 2020 && String.to_integer(passport["eyr"]) <= 2030),
      true <- Regex.match?(~r/#[a-f0-9]{6}/, passport["hcl"]),
      true <- Regex.match?(~r/amb|blu|brn|gry|grn|hzl|oth/, passport["ecl"]),
      true <- Regex.match?(~r/^\d{9}$/, passport["pid"]),
      true <- ((hgt["unit"] == "cm" && String.to_integer(hgt["val"]) >= 150 && String.to_integer(hgt["val"]) <= 193) || (hgt["unit"] == "in" && String.to_integer(hgt["val"]) >= 59 && String.to_integer(hgt["val"]) <= 76))
    do
        true
    else
      _ ->
        false
    end
  end


end