defmodule Lists do
  @doc """
    This function computes the sum of all elements in the list xs. There are
    multiple techniques that can be used for implementing this function, and
    you will learn during the class.

    For this example assignment you can use the following methods:

    - `Enum.empty?/1` returns `true` if the list `xs` is empty
    - `[h|_] = xs` pattern matches on the head element of the list `xs`. If the list
    is empty a MatchError is thrown
    - `[_|t]` pattern matches on the tail of the list `xs`, i.e. the the
    list `xs` without its `head` element
    ''Hint:'' instead of writing a `for` or `while` loop, think of a recursive
    solution.
  """
  @spec sum([integer()]) :: integer()
  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  @doc """
   This method returns the largest element in a list of integers. If the
   list `xs` is empty it throws a `ArgumentError`.

   You can use the same methods of the module `List` as mentioned above.

   ''Hint:'' Again, think of a recursive solution instead of using looping
   constructs. You might need to define an auxiliary method.
  """
  @spec max([integer()]) :: integer()
  def max([]), do: raise(ArgumentError)
  def max([h | t]) do
    case Enum.empty?(t) do
      true -> h
      false -> max(h, max(t))
    end
  end
end
