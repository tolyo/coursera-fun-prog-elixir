defmodule RecfunTest do
  use ExUnit.Case
  doctest Recfun
  import Recfun

  describe "pascal" do
    test "pascal: col=0,row=2" do
      assert pascal(0, 2) === 1
    end

    test "pascal: col=1,row=2" do
      assert pascal(1, 2) === 2
    end

    test "pascal: col=1,row=3" do
      assert pascal(1, 3) === 3
    end
  end

  describe "balance" do
    test "balance: '(if (zero? x) max (/ 1 x))' is balanced" do
      assert "(if (zero? x) max (/ 1 x))" |> String.to_charlist() |> balance()
    end

    test "balance: 'I told him ...' is balanced" do
      assert "I told him (that it's not (yet) done).\n(But he wasn't listening)"
             |> String.to_charlist()
             |> balance()
    end

    test "balance: ':-)' is unbalanced" do
      assert ":-)" |> String.to_charlist() |> balance() == false
    end

    test "balance: counting is not enough" do
      assert "())(" |> String.to_charlist() |> balance() == false
    end
  end

  describe "count_change" do
    test "countChange: example given in instructions" do
      assert countChange(4, [1, 2]) === 3
    end

    test "countChange: sorted CHF" do
      assert countChange(300, [5, 10, 20, 50, 100, 200, 500]) === 1022
    end

    test "countChange: no pennies" do
      assert countChange(301, [5, 10, 20, 50, 100, 200, 500]) === 0
    end

    test "countChange: unsorted CHF" do
      assert countChange(300, [500, 5, 50, 100, 20, 200, 10]) === 1022
    end
  end
end
