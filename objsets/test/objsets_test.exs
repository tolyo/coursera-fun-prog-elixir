defmodule ObjsetsTest do
  use ExUnit.Case
  doctest Objsets

  test "greets the world" do
    assert Objsets.hello() == :world
  end

  # trait TestSets {
  #   val set1 = new Empty
  #   val set2 = set1.incl(new Tweet("a", "a body", 20))
  #   val set3 = set2.incl(new Tweet("b", "b body", 20))
  #   val c = new Tweet("c", "c body", 27)
  #   val d = new Tweet("d", "d body", 29)
  #   val set4c = set3.incl(c)
  #   val set4d = set3.incl(d)
  #   val set5 = set4c.incl(d)
  # }

  # def asSet(tweets: TweetSet): Set[Tweet] = {
  #   var res = Set[Tweet]()
  #   tweets.foreach(res += _)
  #   res
  # }

  # def size(set: TweetSet): Int = asSet(set).size

  # test "filter: on empty set" do
  #   new TestSets {
  #     assert(size(set1.filter(tw => tw.user == "a")) === 0)
  #   }
  # }

  # test "filter: a on set5" do
  #   new TestSets {
  #     assert(size(set5.filter(tw => tw.user == "a")) === 1)
  #   }
  # }

  # test "filter: 20 on set5" do
  #   new TestSets {
  #     assert(size(set5.filter(tw => tw.retweets == 20)) === 2)
  #   }
  # }

  # test "union: set4c and set4d" do
  #   new TestSets {
  #     assert(size(set4c.union(set4d)) === 4)
  #   }
  # }

  # test "union: with empty set (1)" do
  #   new TestSets {
  #     assert(size(set5.union(set1)) === 4)
  #   }
  # }

  # test "union: with empty set (2)" do
  #   new TestSets {
  #     assert(size(set1.union(set5)) === 4)
  #   }
  # }

  #  test "mostRetweeted: with full set" do
  #   new TestSets {
  #     assert(set4d.mostRetweeted.retweets === 29)
  #   }
  # end

  # test "descending: set5" do
  #   new TestSets {
  #     val trends = set5.descendingByRetweet
  #     assert(!trends.isEmpty)
  #     assert(trends.head.user == "c" || trends.head.user == "d")
  #   }
  # end
end
