defmodule StringParserTerrain do
  @spec terrainFunction(any()) :: GameDef.terrain()
  def terrainFunction(level_vector) do
    fn %Pos{row: row, col: col} ->
      try do
        validRow(row, level_vector) && validCol(row, col, level_vector)
      rescue
        _ -> false
      end
    end
  end

  @doc """
  This function should return the position of character `c` in the
  terrain described by `level_vector`. You can assume that the `c`
  appears exactly once in the terrain.
  """
  @spec findChar(String.t(), [[String.t()]]) :: Pos.t()
  def findChar(c, level_vector) do
    {row, col} =
      Enum.reduce_while(level_vector, {0, nil}, fn line, {row, col} ->
        case Enum.find_index(line, fn elem -> elem == c end) do
          nil -> {:cont, {row + 1, col}}
          index -> {:halt, {row, index}}
        end
      end)

    %Pos{row: row, col: col}
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
