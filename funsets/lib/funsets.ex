defmodule Funsets do
  @moduledoc """
    2. Purely Functional Sets.
  """

  @typedoc """
    We represent a set by its characteristic function, i.e.
    its `contains` predicate.
  """
  @type set :: (integer() -> boolean())

  @doc """
    Indicates whether a set contains a given element.
  """
  @spec contains(set, integer()) :: boolean()
  def contains(set, val), do: set.(val)

  @doc """
    Returns the set of the one given element.
  """
  @spec singleton_set(integer()) :: set()
  def singleton_set(x), do: fn y -> x == y end

  @doc """
    Returns the union of the two given sets,
    the sets of all elements that are in either `s` or `t`.
  """
  @spec union(set(), set()) :: set()
  def union(s, t), do: fn v -> contains(s, v) || contains(t, v) end

  @doc """
    Returns the intersection of the two given sets,
    the set of all elements that are both in `s` and `t`.
  """
  @spec intersect(set(), set()) :: set()
  def intersect(s, t), do: fn v -> contains(s, v) && contains(t, v) end

  @doc """
    Returns the difference of the two given sets,
    the set of all elements of `s` that are not in `t`.
  """
  @spec diff(set(), set()) :: set()
  def diff(s, t), do: fn v -> contains(s, v) && !contains(t, v) end

  @doc """
    Returns the subset of `s` for which `p` holds.
  """
  @spec filter(set(), (integer() -> boolean())) :: set()
  def filter(s, p), do: fn v -> p.(v) && contains(s, v) end

  @doc """
    The bounds for `forall` and `exists` are +/- 1000.
  """
  @bound 1000

  @doc """
    Returns whether all bounded integers within `s` satisfy `p`.
  """
  @spec forall(set(), (integer() -> boolean())) :: boolean()
  def forall(s, p) do
    forall_helper(s, p, 0)
  end

  defp forall_helper(_, _, @bound), do: true

  defp forall_helper(s, p, acc) do
    case {contains(s, acc), p.(acc)} do
      {true, false} -> false
      _ -> forall_helper(s, p, acc + 1)
    end
  end

  @doc """
    Returns whether there exists a bounded integer within `s`
    that satisfies `p`.
  """
  @spec exists(set(), (integer() -> boolean())) :: boolean()
  def exists(s, p), do: !forall(s, fn x -> !p.(x) end)

  @doc """
    Returns a set transformed by applying `f` to each element of `s`.
  """
  @spec map(set(), (integer() -> integer())) :: set()
  def map(s, f), do: fn v -> exists(s, fn x -> v == f.(x) end) end

  @doc """
   Displays the contents of a set
  """
  @spec toString(set()) :: binary()
  def toString(s) do
  end

  @doc """
    Prints the contents of a set on the console.
  """
  def printSet(s) do
    IO.puts(toString(s))
  end
end
