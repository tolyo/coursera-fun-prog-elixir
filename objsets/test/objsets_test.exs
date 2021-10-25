defmodule ObjsetsTest do
  use ExUnit.Case
  import TweetSet

  alias TweetSet.{
    Tweet
  }

  setup do
    set1 = TweetSet.Empty
    set2 = incl(set1, Tweet.new("a", "a body", 20))
    set3 = incl(set2, Tweet.new("b", "b body", 20))
    c = Tweet.new("c", "c body", 27)
    d = Tweet.new("d", "d body", 29)
    set4c = incl(set3, c)
    set4d = incl(set3, d)
    set5 = incl(set4c, d)

    [
      set1: set1,
      set2: set2,
      set3: set3,
      c: c,
      d: d,
      set4c: set4c,
      set4d: set4d,
      set5: set5
    ]
  end

  test "filter: on empty set", c do
    assert size(filter(c.set1, fn tw -> tw.user == "a" end)) === 0
  end

  test "filter: a on set5", c do
    assert size(filter(c.set5, fn tw -> tw.user == "a" end)) === 1
  end

  test "filter: 20 on set5", c do
    assert size(filter(c.set5, fn tw -> tw.retweets == 20 end)) === 2
  end

  test "union: set4c and set4d", c do
    assert size(union(c.set4c, c.set4d)) === 4
  end

  test "union: with empty set (1)", c do
    assert size(union(c.set5, c.set1)) === 4
  end

  test "union: with empty set (2)", c do
    assert size(union(c.set1, c.set5)) === 4
  end

  test "mostRetweeted: with full set", c do
    assert mostRetweeted(c.set4d).retweets === 29
  end

  test "descending: set5", c do
    [h|t] = trends = descendingByRetweet(c.set5)
    assert trends != []
    assert [h.user == "c" || h.user == "d"]
  end
end
