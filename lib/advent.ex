defmodule Advent do
  @moduledoc """
  Glad advent
  """

  def read_input(path) do
    expanded = Path.expand(path)
    case File.read(expanded) do
      {:ok, body} -> String.split(body, "\n")
      {:error, reason} -> {:error, reason}
    end
  end

end

