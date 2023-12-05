defmodule Block do
  @type t :: %__MODULE__{
          b1: Pos.t(),
          b2: Pos.t()
        }

  defstruct b1: nil,
            b2: nil

  @spec init(Pos.t(), Pos.t()) :: Block.t()
  def init(b1, b2), do: %Block{b1: b1, b2: b2}

  @doc """
  Returns a block where the `row` coordinates
  of `b1` and `b2` are changed by `d1` and `d2`,
  respectively.
  """
  @spec deltaRow(Block.t(), integer(), integer()) :: Block.t()
  def deltaRow(block, d1, d2) do
    raise(UndefinedFunctionError)
  end

  @doc """
  Returns a block where the `col` coordinates of `b1` and `b2` are
  changed by `d1` and `d2`, respectively.
  """
  @spec deltaCol(Block.t(), integer(), integer()) :: Block.t()
  def deltaCol(block, d1, d2) do
    raise(UndefinedFunctionError)
  end

  @doc """
  The block obtained by moving left
  """
  @spec left(Block.t()) :: Block.t()
  def left(block) do
    raise(UndefinedFunctionError)
  end

  @doc """
  The block obtained by moving right
  """
  @spec right(Block.t()) :: Block.t()
  def right(block) do
    raise(UndefinedFunctionError)
  end

  @doc """
  The block obtained by moving up
  """
  @spec up(Block.t()) :: Block.t()
  def up(block) do
    raise(UndefinedFunctionError)
  end

  @doc """
    The block obtained by moving down
  """
  @spec down(Block.t()) :: Block.t()
  def down(block) do
    raise(UndefinedFunctionError)
  end

  @doc """
  Returns the list of blocks that can be obtained by moving
  the current block, together with the corresponding move.
  """
  @spec neighbors(Block.t()) :: [{Block.t(), GameDef.move()}]
  def neighbors(block) do
    raise(UndefinedFunctionError)
  end

  @doc """
  Returns the list of positions reachable from the current block
  which are inside the terrain.
  """
  @spec legalNeighbors(Block.t(), GameDef.terrain()) :: [{Block.t(), GameDef.move()}]
  def legalNeighbors(block, terrain) do
    raise(UndefinedFunctionError)
  end

  @doc """
    Returns true if the block is standing
  """
  @spec isStanding(Block.t()) :: boolean()
  def isStanding(%Block{b1: b1, b2: b2}) do
    raise(UndefinedFunctionError)
  end

  @doc """
    Returns `true` if the block is entirely inside the terrain.
  """
  @spec isLegal(Block.t(), GameDef.terrain()) :: boolean()
  def isLegal(%Block{b1: b1, b2: b2}, terrain) do
    raise(UndefinedFunctionError)
  end
end
