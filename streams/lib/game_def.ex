defmodule GameDef do
  @typedoc """
  The position where the block is located initially.
  This value is left abstract, it will be defined in concrete
  instances of the game.
  """
  @type startPos :: Pos.t()

  @typedoc """
  The target position where the block has to go.
  This value is left abstract.
  """
  @type goal :: Pos.t()

  @typedoc """
  The terrain is represented as a function from positions to
  booleans. The function returns `true` for every position that
  is inside the terrain.
  As explained in the documentation of class `Pos`, the `x` axis
  is the vertical one and increases from top to bottom.
  """
  @type terrain :: (Pos.t() -> boolean())

  @typedoc """
  In Bloxorz, we can move left, right, Up or down.
  """
  @type move :: :LEFT | :RIGHT | :UP | :DOWN

  @typedoc """
  The block at the start position of
  the game.
  """
  @type startBlock() :: (-> Block.t())
end
