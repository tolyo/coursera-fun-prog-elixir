defmodule Inflevel do
  @moduledoc """

  Defines an infinite terrain, where the block can
  go on any position.

  This module is useful for testing. It can be used to find
  the shortest path between two positions without terrain
  restrictions.
  """
  use Solver

  @spec startPos() :: Pos.t()
  def startPos, do: Pos.init(1, 3)

  @spec goal() :: Pos.t()
  def goal, do: Pos.init(5, 8)

  @spec terrain() :: GameDef.terrain()
  def terrain(), do: fn _ -> true end
end
