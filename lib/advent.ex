defmodule Advent do
  @moduledoc """
  Glad advent
  """

  def day(day) do
    case File.read(Path.join(:code.priv_dir(:advent), "#{day}.txt")) do
      {:ok, body} -> body
      {:error, reason} -> {:error, reason}
    end
  end

end

