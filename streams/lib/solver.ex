defmodule Solver do
  @moduledoc """
    This component implements the solver
    for the Bloxorz game
  """

  @doc """
    Returns `true` if the block `b` is at the final position
  """
  @spec done(Block.t(), Pos.t()) :: boolean()
  def done(%Block{b1: b1, b2: b2}, goal) do
    b1 == goal && b2 == goal
  end

  @doc """
    This function takes two arguments: the current block `b` and
    a list of moves `history` that was required to reach the
    position of `b`.

    The `head` element of the `history` list is the latest move
    that was executed, i.e. the last move that was performed for
    the block to end up at position `b`.

    The function returns a lazy list of pairs: the first element of
    the each pair is a neighboring block, and the second element
    is the augmented history of moves required to reach this block.

    It should only return valid neighbors, i.e. block positions
    that are inside the terrain.
  """
  @spec neighborsWithHistory(Block.t(), [Move.t()], Terrain.t()) :: [{Block.t(), [Move.t()]}]
  def neighborsWithHistory(block, history, terrain) do
    ln = Block.legalNeighbors(block, terrain)
    res = for {neighbor, move} <- ln do
      {neighbor, [move | history]}
    end
    res
  end

  @doc """
    This function returns the list of neighbors without the block
    positions that have already been explored. We will use it to
    make sure that we don't explore circular paths.
  """
  @spec newNeighborsOnly([{Block.t(), [Move.t()]}], MapSet.t()) :: [{Block.t(), [Move.t()]}]
  def newNeighborsOnly(neighbors, explored) do
    Enum.filter(neighbors, fn {block, _} ->
      not MapSet.member?(explored, block)
    end)
  end

  @doc """
    The function `from` returns the lazy list of all possible paths
    that can be followed, starting at the `head` of the `initial`
    lazy list.

    The blocks in the lazy list `initial` are sorted by ascending path
    length: the block positions with the shortest paths (length of
    move list) are at the head of the lazy list.

    The parameter `explored` is a set of block positions that have
    been visited before, on the path to any of the blocks in the
    lazy list `initial`. When search reaches a block that has already
    been explored before, that position should not be included a
    second time to avoid cycles.

    The resulting lazy list should be sorted by ascending path length,
    i.e. the block positions that can be reached with the fewest
    amount of moves should appear first in the lazy list.

    Note: the solution should not look at or compare the lengths
    of different paths - the implementation should naturally
    construct the correctly sorted lazy list.
  """
  @spec from([{Block.t(), [Move.t()]}], MapSet.t()) :: [{Block.t(), [Move.t()]}]

  def from([], _) do [] end
  def from(initial, explored) do
    raise(UndefinedFunctionError)
  end

  @doc """
    The lazy list of all paths that begin at the starting block.
  """
  @spec pathsFromStart() :: [{Block.t(), [Move.t()]}]
  def pathsFromStart() do
    raise(UndefinedFunctionError)
  end

  @doc """
    Returns a lazy list of all possible pairs of the goal block along
    with the history how it was reached.
  """
  @spec pathsToGoal() :: [{Block.t(), [Move.t()]}]
  def pathsToGoal() do
    raise(UndefinedFunctionError)
  end

  @doc """
    The (or one of the) shortest sequence(s) of moves to reach the
    goal. If the goal cannot be reached, the empty list is returned.

    Note: the `head` element of the returned list should represent
    the first move that the player should perform from the starting
    position.
  """
  @spec solution() :: [{Block.t(), [Move.t()]}]
  def solution() do
    if Enum.empty?(pathsToGoal()) do []
    else elem(Enum.min_by(pathsToGoal(), fn {_, moves} -> length(moves) end), 1)
    end
  end
end
