defmodule PatmatTest do
  use ExUnit.Case
  import Huffman

  alias Huffman.{
    Leaf,
    Fork
  }

  setup do
    t1 = Fork.new(Leaf.new('a', 2), Leaf.new('b', 3), ['a', 'b'], 5)

    t2 =
      Fork.new(
        Fork.new(Leaf.new('a', 2), Leaf.new('b', 3), ['a', 'b'], 5),
        Leaf.new('d', 4),
        ['a', 'b', 'd'],
        9
      )

    [
      t1: t1,
      t2: t2
    ]
  end

  test "weight of a larger tree", c do
    assert weight(c.t1) === 5
  end

  test "chars of a larger tree", c do
    assert chars(c.t2) === ['a', 'b', 'd']
  end

  test "string2chars(\"hello, world\")" do
    assert string2Chars("hello, world") === ['h', 'e', 'l', 'l', 'o', ',', ' ', 'w', 'o', 'r', 'l', 'd']
  end

  test "times" do
    assert "test" |> string2Chars() |> times() === [{'t', 2}, {'e', 1}, {'s', 1}]
  end

  test "makeOrderedLeafList for some frequency table" do
    assert [
             {'t', 2},
             {'e', 1},
             {'x', 3}
           ]
           |> makeOrderedLeafList() === [Leaf.new('e', 1), Leaf.new('t', 2), Leaf.new('x', 3)]
  end

  test "singleton" do
    assert singleton([Leaf.new('e', 1)]) == true
    assert singleton([]) == false
  end

  test "combine of some leaf list" do
    leaflist = [Leaf.new('e', 1), Leaf.new('t', 2), Leaf.new('x', 4)]

    assert combine(leaflist) === [
             Fork.new(Leaf.new('e', 1), Leaf.new('t', 2), ['e', 't'], 3),
             Leaf.new('x', 4)
           ]
  end

  test "until(singleton, combine)(trees)" do
    trees = [Leaf.new('e', 1), Leaf.new('t', 2)]

    assert until(&singleton(&1), &combine(&1)).(trees) === [
             Fork.new(Leaf.new('e', 1), Leaf.new('t', 2), ['e', 't'], 3)
           ]
  end

  test "create code tree" do
    assert createCodeTree(string2Chars("tet")) ==
             Fork.new(Leaf.new('e', 1), Leaf.new('t', 2), ['e', 't'], 3)
  end
end
