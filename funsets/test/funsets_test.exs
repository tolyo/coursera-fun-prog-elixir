defmodule FunsetsTest do
  use ExUnit.Case
  doctest Funsets
  import Funsets

  setup do
    [
      s1: singleton_set(1),
      s2: singleton_set(2),
      s3: singleton_set(3)
    ]
  end

  test "contains is implemented" do
    assert contains(fn _x -> true end, 100)
  end

  test "singleton_set(1) contains 1", c do
    assert(contains(c.s1, 1), "Singleton")
  end

  test "union contains all elements", c do
    s = union(c.s1, c.s2)
    assert contains(s, 1)
    assert contains(s, 2)
    assert !contains(s, 3)
  end

  test "forall elements in bound" do
    s1 = singleton_set(100)
    assert forall(s1, fn x -> x > 0 end)
  end

  test "exists" do
    s1 = singleton_set(10)
    assert exists(s1, fn x -> x > 0 end)
  end

  test "map" do
    s1 = singleton_set(10)
    s2 = map(s1, fn x -> x * 2 end)
    # printSet(s2)
    assert contains(s2, 20)
  end
end
