defmodule Recfun do
  @moduledoc """
    Documentation for `Recfun`.
  """

  @spec main() :: none()
  def main() do
    IO.puts("Pascal's Triangle")

    for row <- 0..10,
        col <- 0..row do
      IO.puts(pascal(col, row) + " ")
      IO.puts("\n")
    end
  end

  @doc """
    Exercise 1
  """
  @spec pascal(non_neg_integer(), non_neg_integer()) :: non_neg_integer()
  def pascal(col, row), do: raise(UndefinedFunctionError)

  @doc """
    Exercise 2
  """
  @spec balance(charlist()) :: boolean()
  def balance(word), do: raise(UndefinedFunctionError)

  @doc """
    Exercise 3
  """
  @spec countChange(non_neg_integer(), [non_neg_integer()]) :: non_neg_integer()
  def countChange(money, coins), do: raise(UndefinedFunctionError)
end
