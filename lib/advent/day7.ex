defmodule Advent.Day7 do

  def part1(input) do
    tree = tree(input)
    (for {p,_} <- tree, has_path(tree, p, "shiny gold"), do: p) |> length
  end

  def part2(input), do: tree(input) |> count_bags("shiny gold")

  defp tree(input) do
    for row <- Advent.read_input(input), reduce: %{} do
      acc ->
        [parent | [children | _] ] = String.split(row, " bags contain")
        acc = Map.put(acc, parent, [])
        for ch <- Regex.scan(~r/(\d)+ ([a-z\ ]+) bag/, children), reduce: acc do
          a -> Map.update!(a, parent, &([{String.to_integer(Enum.at(ch,1)), Enum.at(ch, 2)} | &1]))
        end
    end
  end

  defp has_path(tree, parent, child) do
    case List.keyfind(tree[parent], child, 1, false) do
      false -> Enum.reduce(tree[parent], false, fn {_,x},acc -> acc || has_path(tree,x,child) end)
      _ -> true
    end
  end

  defp count_bags(tree, parent) do
    for {n,ch} <- tree[parent], reduce: 0 do acc -> acc + n + (n * count_bags(tree,ch)) end
  end

end
