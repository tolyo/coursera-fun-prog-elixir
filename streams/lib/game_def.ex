defmodule GameDef do
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
end
