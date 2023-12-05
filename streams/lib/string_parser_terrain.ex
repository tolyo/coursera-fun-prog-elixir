defmodule StringParserTerrain do
  @doc """
  The resulting function should return `true` if the position `pos` is
  a valid position (not a '-' character) inside the terrain described
  by `level_vector`.
  """
  @spec terrainFunction(any()) :: GameDef.terrain()
  def terrainFunction(level_vector) do
    raise(UndefinedFunctionError)
  end

  @doc """
  This function should return the position of character `c` in the
  terrain described by `level_vector`. You can assume that the `c`
  appears exactly once in the terrain.
  """
  @spec findChar(String.t(), [[String.t()]]) :: Pos.t()
  def findChar(c, level_vector) do
    raise(UndefinedFunctionError)
  end

  @spec vector(String.t()) :: [[String.t()]]
  def vector(level) do
    String.split(level, "\n")
    |> Enum.map(&String.graphemes/1)
  end

  @spec terrain([[String.t()]]) :: GameDef.terrain()
  def terrain(level_vector), do: terrainFunction(level_vector)

  @spec startPos([[String.t()]]) :: Pos.t()
  def startPos(level_vector), do: findChar("S", level_vector)

  @spec goal([[String.t()]]) :: Pos.t()
  def goal(level_vector), do: findChar("T", level_vector)

  defp validRow(row, level_vector) when row >= 0 and row < length(level_vector), do: true
  defp validRow(_, _), do: false

  defp validCol(_, col, level_vector) when col >= 0 and col < length(hd(level_vector)),
    do: true

  defp validCol(_, _, _), do: false
end
