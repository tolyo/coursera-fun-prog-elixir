defmodule ListsTest do
  use ExUnit.Case
  import Lists

  @doc """
    Tests are written using the `test` macro which takes a test description as an argument.
    This description has to be unique, no two tests can have the same description.

    The most common way to implement a test body is using the method `assert`
    which tests that its argument evaluates to `true`. So one of the simplest
    successful tests is the following:
  """
  test "one plus one is two" do
    assert 1 + 1 === 2
  end

  @doc """
    In order to test the exceptional behavior of a methods, ExUnit offers
    the `assert_raise` operation.
    *
    In the following example, we test the fact that the method `int_not_zero`
    will throw an `ArgumentError`
  """

  test "intNotZero throws an exception if its argument is 0" do
    int_not_zero = fn x ->
      if x == 0 do
        raise ArgumentError
      end
    end

    assert_raise ArgumentError, fn -> int_not_zero.(0) end
  end

  @doc """
    Now we finally write some tests for the list functions that have to be
    implemented for this assignment. We fist import all members of the
    `Lists` module.

    We only provide two very basic tests for you. Write more tests to make
    sure your `sum` and `max` methods work as expected.
    In particular, write tests for corner cases: negative numbers, zeros, and empty lists.
    It is allowed to have multiple `assert` statements inside one test,
    however it is recommended to write an individual `test` statement for
    every tested aspect of a method.
  """

  test "sum of a few numbers" do
    assert sum([1, 2, 0]) === 3
  end

  test "max of a empty list" do
    assert_raise ArgumentError, fn ->
      max([])
    end
  end

  test "max of a few numbers" do
    assert max([3, 7, 2]) === 7
  end
end
