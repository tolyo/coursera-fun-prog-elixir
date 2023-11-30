defmodule Level1 do
  @spec level :: String.t()
  def level do
    """
    o0o-------
    oSoooo----
    ooooooooo-
    -ooooooooo
    -----ooToo
    ------ooo-
    """
  end

  @spec vector() :: [[binary()]]
  def vector, do: StringParserTerrain.vector(level())

  @spec terrain() :: GameDef.terrain()
  def terrain, do: StringParserTerrain.terrain(vector())

  @spec startPos() :: Pos.t()
  def startPos, do: StringParserTerrain.startPos(vector())

  @spec goal() :: Pos.t()
  def goal, do: StringParserTerrain.goal(vector())

  @spec done(Block.t()) :: boolean()
  def done(b), do: Solver.done(b, goal())
end
