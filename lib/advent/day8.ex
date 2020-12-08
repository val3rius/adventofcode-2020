defmodule Advent.Day8 do

  def part1(), do: Advent.day(8) |> String.split("\n") |> exec
  def part2(), do: Advent.day(8) |> String.split("\n") |> fix |> exec

  def exec(program), do: exec(program, 0, 0, MapSet.new())
  def exec(program, acc, row, used_rows) when row == length(program) do
    %{acc: acc, used_rows: used_rows, loops: false}
  end
  def exec(program, _, row, _) when row > length(program), do: :fail
  def exec(program, acc, row, used_rows) do
    [ instruction | [arg | _ ]] = String.split(Enum.at(program, row))
    case row in used_rows do
      true -> %{acc: acc, used_rows: used_rows, loops: true}
      false -> case instruction do
       "jmp" -> exec(program, acc, row+String.to_integer(arg), MapSet.put(used_rows, row))
       "nop" -> exec(program, acc, row+1, MapSet.put(used_rows, row))
       "acc" -> exec(program, acc+String.to_integer(arg), row+1, MapSet.put(used_rows, row))
       end
    end
  end

  def fix(program) do
    used_instructions = exec(program)[:used_rows]
    for {row,idx} <- Enum.with_index(program), reduce: [] do
      acc -> [ instruction | [arg | _ ]] = String.split(row)
              case length(acc) > 0 do
                true -> acc
                false -> fixed_program = (case instruction do
                    "nop" -> List.replace_at(program, idx, "jmp " <> arg)
                    "jmp" -> List.replace_at(program, idx, "nop " <> arg)
                    _ -> program
                  end)
                   case idx in used_instructions && exec(fixed_program)[:loops] == false do
                     true -> fixed_program
                     false -> acc
                   end
             end
    end
  end

end