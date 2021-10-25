defmodule TweetSetInterface do
  @callback incl(tweet_set :: TweetSet.t(), tweet :: Tweet.t()) :: TweetSet.t()
  @callback remove(tweet_set :: TweetSet.t(), tweet :: Tweet.t()) :: TweetSet.t()
  @callback contains(tweet_set :: TweetSet.t(), tweet :: Tweet.t()) :: boolean
  @callback foreach(tweet_set :: TweetSet.t(), (x :: Tweet.t() -> Tweet.t())) :: TweetSet.t()
  @callback union(tweet_set :: TweetSet.t(), that :: TweetSet.t()) :: TweetSet.t()
  @callback mostRetweeted(tweet_set :: TweetSet.t()) :: Tweet.t()
  @callback descendingByRetweet(tweet_set :: TweetSet.t()) :: TweetList.t()
end

defmodule TweetSet do
  @behaviour TweetSetInterface

  @moduledoc """
    This represents a set of objects of type `Tweet` in the form of a binary search
    tree. Every branch in the tree has two children (two `TweetSet`s). There is an
    invariant which always holds: for every branch `b`, all elements in the left
    subtree are smaller than the tweet at `b`. The elements in the right subtree are
    larger.

    Note that the above structure requires us to be able to compare two tweets (we
    need to be able to say which of two tweets is larger, or if they are equal). In
    this implementation, the equality / order of tweets is based on the tweet's text
    (see `def incl`). Hence, a `TweetSet` could not contain two tweets with the same
    text from different users.

    The advantage of representing sets as binary search trees is that the elements
    of the set can be found quickly. If you want to learn more you can take a look
    at the Wikipedia page [1], but this is not necessary in order to solve this
    assignment.
    [1] http://en.wikipedia.org/wiki/Binary_search_tree
  """

  @type t :: NonEmpty.t() | Empty.t()

  defmodule NonEmpty do
    @type t :: %NonEmpty{
            elem: Tweet.t(),
            left: TweetSet.t(),
            right: TweetSet.t()
          }

    defstruct elem: nil,
              left: nil,
              right: nil
  end

  defmodule Empty do
    @type t :: nil
  end

  defmodule Tweet do
    @type t :: %Tweet{
            user: String.t(),
            text: String.t(),
            retweets: non_neg_integer()
          }

    defstruct user: nil,
              text: nil,
              retweets: nil

    @spec new(String.t(), String.t(), non_neg_integer()) :: Tweet.t()
    def new(user, text, retweets), do: %Tweet{user: user, text: text, retweets: retweets}
  end

  @spec new(Tweet.t()) :: NonEmpty.t()
  def new(elem), do: %NonEmpty{elem: elem, left: Empty, right: Empty}

  @spec new(Tweet.t(), TweetSet.t(), TweetSet.t()) :: NonEmpty.t()
  def new(elem, left, right), do: %NonEmpty{elem: elem, left: left, right: right}

  def size(Empty), do: 0
  def size(%NonEmpty{left: left, right: right}), do: 1 + size(left) + size(right)

  @spec filter(TweetSet.t(), (x: Tweet.t() -> boolean())) :: TweetSet.t()
  def filter(set, p) do
    raise(UndefinedFunctionError)
  end

  @doc """
    This is a helper method for `filter` that propagates the
    accumulated tweets.
  """
  @spec filterAcc(TweetSet.t(), (x: Tweet.t() -> boolean()), TweetSet.t()) :: TweetSet.t()
  def filterAcc(set, p, acc) do
    raise(UndefinedFunctionError)
  end

  @doc """
    Returns a new `TweetSet` that is the union of `TweetSet`s `x` and `y`.
  """
  @spec union(TweetSet.t(), TweetSet.t()) :: TweetSet.t()
  def union(x, y) do
    raise(UndefinedFunctionError)
  end

  @doc """
    Returns the tweet from this set which has the greatest retweet count.
    Calling `mostRetweeted` on an empty set should throw an `ArgumentError`
  """
  @spec mostRetweeted(TweetSet.t()) :: Tweet.t()
  def mostRetweeted(set) do
    raise(UndefinedFunctionError)
  end

  @doc """
   Returns a list containing all tweets of this set, sorted by retweet count
   in descending order. In other words, the head of the resulting list should
   have the highest retweet count.
  """
  @spec descendingByRetweet(TweetSet.t()) :: [Tweet.t()]
  def descendingByRetweet(set) do
    raise(UndefinedFunctionError)
  end

  # The following methods are already implemented
  def contains(Empty, _), do: false

  def contains(%NonEmpty{} = set, %Tweet{} = x) do
    cond do
      x.text < set.elem -> contains(set.left, x)
      set.elem < x.text -> contains(set.right, x)
      true -> true
    end
  end

  def incl(Empty, tweet), do: %NonEmpty{elem: tweet, left: Empty, right: Empty}

  def incl(%NonEmpty{} = set, %Tweet{} = x) do
    cond do
      x.text < set.elem.text -> new(set.elem, incl(set.left, x), set.right)
      set.elem.text < x.text -> new(set.elem, set.left, incl(set.right, x))
      true -> set
    end
  end

  def remove(Empty, tweet), do: Empty

  def remove(%NonEmpty{} = set, x) do
    cond do
      x.text < set.elem.text -> new(set.elem, remove(set.left, x), set.right)
      set.elem.text < x.text -> new(set.elem, set.left, remove(set.right, x))
      true -> union(set.left, set.right)
    end
  end

  def foreach(Empty, _f), do: Empty

  def foreach(%NonEmpty{} = set, f) do
    new(f.(set.elem), foreach(set.left, f), foreach(set.right, f))
  end
end
