defmodule Level1 do
  use Solver
  use Level

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

  # @spec vector() :: [[binary()]]
  # defdelegate vector, to: Level

  # @spec terrain() :: GameDef.terrain()
  # defdelegate terrain(), to: Level

  # @spec startPos() :: Pos.t()
  # defdelegate startPos(), to: Level

  # @spec goal() :: Pos.t()
  # defdelegate goal(), to: Level

  # @spec done(Block.t()) :: boolean()
  # defdelegate done(b), to: Level
end
