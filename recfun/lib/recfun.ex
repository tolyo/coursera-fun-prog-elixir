defmodule Recfun do
  @moduledoc """
    Documentation for `Recfun`.
  """

  @spec main() :: none()
  def main() do
    IO.puts("Pascal's Triangle")

    for row <- 0..10 do
      for col <- 0..row do
        IO.write("#{pascal(col, row)} ")
      end

      IO.puts("\n")
    end
  end

  @doc """
    Exercise 1
  """
  @spec pascal(non_neg_integer(), non_neg_integer()) :: non_neg_integer()
  def pascal(_, 0), do: 1
  def pascal(0, _), do: 1
  def pascal(s, s), do: 1
  def pascal(c, r), do: pascal(c - 1, r - 1) + pascal(c, r - 1)

  @doc """
    Exercise 2
  """
  @spec balance(charlist()) :: boolean()
  def balance(word), do: balance_helper(word, 0)

  defp balance_helper([], 0), do: true
  defp balance_helper([], _), do: false
  defp balance_helper([?) | _], 0), do: false

  defp balance_helper([h | t], acc) do
    case h do
      ?( -> balance_helper(t, acc + 1)
      ?) -> balance_helper(t, acc - 1)
      _ -> balance_helper(t, acc)
    end
  end

  @doc """
    Exercise 3
  """
  @spec countChange(non_neg_integer(), [non_neg_integer()]) :: non_neg_integer()
  def countChange(0, []), do: 1
  def countChange(_, []), do: 0
  def countChange(val, _) when val < 0, do: 0
  def countChange(money, [h | t] = list), do: countChange(money, t) + countChange(money - h, list)
end
