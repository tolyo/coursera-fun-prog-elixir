defmodule Block do

  @type t :: %Block{
      b1: Pos.t(),
      b2: Pos.t()
  }
  defstruct b1: nil,
            b2: nil

  @spec init(Pos.t(), Pos.t()) :: Block.t()
  def init(b1, b2) when
    b1.row <= b2.row and
    b1.col <= b2.col, do:
      %Block{b1: b1, b2: b2}

  @doc """
    Returns a block where the `row` coordinates
    of `b1` and `b2` are changed by `d1` and `d2`,
    respectively.
  """
  @spec deltaRow(Block.t(), non_neg_integer(), non_neg_integer()) :: Block.t()
  def deltaRow(block, d1, d2) do
    Block.init(
      Pos.deltaCrow(block.b1, d1),
      Pos.deltaRow(block.b2, d2)
    )
  end

end
