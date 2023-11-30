defmodule Level0 do
  use Solver

  @spec level :: String.t()
  def level do
    """
    -----
    --ST--
    --oo--
    --oo--
    ------
    """
  end

  @spec vector() :: [[binary()]]
  defdelegate vector, to: Level

  @spec terrain() :: GameDef.terrain()
  defdelegate terrain(), to: Level

  @spec startPos() :: Pos.t()
  defdelegate startPos(), to: Level

  @spec goal() :: Pos.t()
  defdelegate goal(), to: Level

  @spec done(Block.t()) :: boolean()
  defdelegate done(b), to: Level
end
