defmodule Pos do
  @moduledoc """
    The case class `Pos` encodes positions in the terrain.
    IMPORTANT NOTE
    - The `row` coordinate denotes the position on the vertical axis
    - The `col` coordinate is used for the horizontal axis
    - The coordinates increase when moving down and right

   Illustration:
        0 1 2 3   <- columns
    ------------
    0 | o o o o
    1 | o o o o
    2 | o # o o    # is at position Pos.init(2, 1)
    3 | o o o o
    ^
    |
    row
  """

  @type t :: %__MODULE__{
    row: integer(),
    col: integer()
  }
  defstruct row: nil,
            col: nil

  @spec init(integer(), integer()) :: Pos.t()
  def init(row, col), do: %Pos{row: row, col: col}

  @doc """
    The position obtained by changing the `col` coordinate by `d`
  """
  @spec deltaColumn(Pos.t(), integer()) :: Pos.t()
  def deltaColumn(pos, d), do: %{pos | col: pos.col + d}

  @doc """
    The position obtained by changing the `row` coordinate by `d`
  """
  @spec deltaRow(Pos.t(), integer()) :: Pos.t()
  def deltaRow(pos, d), do: %{pos | row: pos.row + d}
end
