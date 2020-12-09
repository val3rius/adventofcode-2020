defmodule Advent.Day9 do

  def run() do
    data = Advent.day(9)
           |> String.split("\n")
           |> Enum.map(&String.to_integer/1)

    {us1,val1} = :timer.tc(&Advent.Day9.part1/1, [data])
    {us2,val2} = :timer.tc(&Advent.Day9.part2/2, [data, val1])

    IO.puts("Part 1: Got #{val1} in #{us1 / 1_000} ms")
    IO.puts("Part 2: Got #{val2} in #{us2 / 1_000} ms")
  end

  def part1(data) do
    preamble_length = 25
    preamble = Enum.slice(data, 0, preamble_length)
    numbers = Enum.slice(data, preamble_length, length(data)-preamble_length)
    find_next_invalid(numbers, preamble)
  end

  def part2(data, invalid_number) do
    numbers = Enum.slice(data, 0, Enum.find_index(data, &(&1==invalid_number)))
    search_range(numbers, invalid_number, 2)
  end

  def search_range(numbers,_,range_length) when range_length >= length(numbers), do: :fail
  def search_range(numbers, result, range_length) do
    res = (Enum.reduce_while(Enum.with_index(numbers), [], fn {_,idx},acc ->
        candidate = Enum.slice(numbers, idx, range_length)
        case sum_range(candidate) == result do
          true -> {:halt, candidate}
          false -> {:cont, acc}
        end
    end)) |> Enum.sort()
    case length(res) > 0 do
      true -> List.first(res) + List.last(res)
      false -> search_range(numbers, result, range_length+1)
    end
  end

  def sum_range(range), do: Enum.reduce(range, 0, &(&1+&2))

  def find_next_invalid([], _), do: :no_invalid
  def find_next_invalid([ number | tail ], preamble) do
    combs = for x <- preamble, y <- preamble, &(&1!=&2), do: {x,y}
    is_valid = Enum.reduce_while(combs, false, fn {x,y},_ ->
      case x+y==number do
        true -> {:halt, true}
        false -> {:cont, false}
      end
    end)
    case is_valid do
      false -> number
      true -> find_next_invalid(tail, List.delete_at(preamble,0)++[number])
    end

  end

end