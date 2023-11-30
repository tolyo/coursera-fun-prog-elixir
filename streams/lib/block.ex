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
    %Block{
      b1: Pos.deltaRow(block.b1, d1),
      b2: Pos.deltaRow(block.b2, d2)
    }
  end

  @doc """
  Returns a block where the `col` coordinates of `b1` and `b2` are
  changed by `d1` and `d2`, respectively.
  """
  @spec deltaCol(Block.t(), integer(), integer()) :: Block.t()
  def deltaCol(block, d1, d2) do
    Block.init(
      Pos.deltaColumn(block.b1, d1),
      Pos.deltaColumn(block.b2, d2)
    )
  end

  @doc """
  The block obtained by moving left
  """
  @spec left(Block.t()) :: Block.t()
  def left(block) do
    case isStanding(block) do
      true ->
        block |> deltaCol(-2, -1)

      _ ->
        case block.b1.row == block.b2.row do
          true ->
            block |> deltaCol(-1, -2)

          false ->
            block |> deltaCol(-1, -1)
        end
    end
  end

  @doc """
  The block obtained by moving right
  """
  @spec right(Block.t()) :: Block.t()
  def right(block) do
    case isStanding(block) do
      true ->
        block |> deltaCol(1, 2)

      _ ->
        case block.b1.row == block.b2.row do
          true ->
            block |> deltaCol(2, 1)

          false ->
            block |> deltaCol(1, 1)
        end
    end
  end

  @doc """
  The block obtained by moving up
  """
  @spec up(Block.t()) :: Block.t()
  def up(block) do
    case isStanding(block) do
      true ->
        block |> deltaRow(-2, -1)

      _ ->
        case block.b1.row == block.b2.row do
          true ->
            block |> deltaRow(-1, -1)

          false ->
            block |> deltaRow(-1, -2)
        end
    end
  end

  @doc """
    The block obtained by moving down
  """
  @spec down(Block.t()) :: Block.t()
  def down(block) do
    case isStanding(block) do
      true ->
        block |> deltaRow(1, 2)

      _ ->
        case block.b1.row == block.b2.row do
          true ->
            block |> deltaRow(1, 1)

          false ->
            block |> deltaRow(2, 1)
        end
    end
  end

  @doc """
  Returns the list of blocks that can be obtained by moving
  the current block, together with the corresponding move.
  """
  @spec neighbors(Block.t()) :: [{Block.t(), GameDef.move()}]
  def neighbors(block) do
    [
      {left(block), :left},
      {right(block), :right},
      {up(block), :up},
      {down(block), :down}
    ]
  end

  @doc """
  Returns the list of positions reachable from the current block
  which are inside the terrain.
  """
  @spec legalNeighbors(Block.t(), GameDef.terrain()) :: [{Block.t(), GameDef.move()}]
  def legalNeighbors(block, terrain) do
    block
    |> neighbors()
    |> Enum.filter(fn {neighborBlock, _} -> isLegal(neighborBlock, terrain) end)
  end

  @doc """
    Returns true if the block is standing
  """
  @spec isStanding(Block.t()) :: boolean()
  def isStanding(%Block{b1: b1, b2: b2}) do
    b1 == b2
  end

  @doc """
    Returns `true` if the block is entirely inside the terrain.
  """
  @spec isLegal(Block.t(), GameDef.terrain()) :: boolean()
  def isLegal(%Block{b1: b1, b2: b2}, terrain) do
    terrain.(b1) && terrain.(b2)
  end
end
