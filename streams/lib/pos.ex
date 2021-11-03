defmodule Pos do
  @type t :: %Pos{
          x: non_neg_integer(),
          y: non_neg_integer()
        }
  defstruct x: nil,
            y: nil

  @spec init(non_neg_integer(), non_neg_integer()) :: Pos.t()
  def init(x, y), do: %Pos{x: x, y: y}

  @doc """
    The position obtained by changing the `x` coordinate by `d`
  """
  @spec dx(Pos.t(), non_neg_integer()) :: Pos.t()
  def dx(pos, d), do: %{pos | x: pos.x + d}

  @doc """
    The position obtained by changing the `y` coordinate by `d`
  """
  @spec dy(Pos.t(), non_neg_integer()) :: Pos.t()
  def dy(pos, d), do: %{pos | y: pos.y + d}
end
