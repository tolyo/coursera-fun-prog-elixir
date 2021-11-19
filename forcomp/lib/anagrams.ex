defmodule Anagrams do
  @typedoc """
    A word is simply a `String`
  """
  @type word :: String.t()

  @typedoc """
   A sentence is a `List` of words.
  """
  @type sentence :: [word]

  @doc """
    `occurences` is a `List` of pairs of characters and positive integers saying
    how often the character appears.
   This list is sorted alphabetically w.r.t. to the character in each pair.
   All characters in the occurrence list are lowercase.

   Any list of pairs of lowercase characters and their frequency which is not sorted
   is **not** an occurrence list.

   Note: If the frequency of some character is zero, then that character should not be
   in the list.
  """
  @type occurences :: [{char(), non_neg_integer()}]

  @doc """
    The dictionary is simply a sequence of words.
    It is predefined and obtained as a sequence using the utility method `loadDictionary`.
  """
  @spec dictionary() :: [word]
  def dictionary() do
    Dictionary.loadDictionary()
  end

  @doc """
    Converts the word into its character occurrence list.
    Note: the uppercase and lowercase version of the character are treated as the
    same character, and are represented as a lowercase character in the occurrence list.
    Note: you must use `groupBy` to implement this method!
  """
  @spec wordOccurrences(word) :: occurences
  def wordOccurrences(w) do
    w
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.map(&String.to_charlist(&1))
    |> wordOccurrences_helper()
  end

  defp wordOccurrences_helper(chars) do
    case chars do
      [] ->
        []

      [h | t] ->
        chars
        |> Enum.group_by(&(&1 == h))
        |> case do
          %{true: heads, false: tails} ->
            [{h, length(heads)} | wordOccurrences_helper(tails)]

          %{true: heads} ->
            [{h, length(heads)}]
        end
    end
  end

  @doc """
    Converts a sentence into its character occurrence list.
  """
  @spec sentenceOccurrences(sentence) :: occurences()
  def sentenceOccurrences(s) do
    s
    |> Enum.join()
    |> wordOccurrences()
  end

  @doc """
    The `dictionaryByoccurences` is a `Map` from different occurrences to a sequence of all
    the words that have that occurrence count.
    This map serves as an easy way to obtain all the anagrams of a word given its occurrence list.
    For example, the word "eat" has the following character occurrence list:
        `List(('a', 1), ('e', 1), ('t', 1))`
    Incidentally, so do the words "ate" and "tea".
    This means that the `dictionaryByoccurences` map will contain an entry:
      List(('a', 1), ('e', 1), ('t', 1)) -> Seq("ate", "eat", "tea")
  """
  @spec dictionaryByOccurrences() :: %{occurences => [word]}
  def dictionaryByOccurrences() do
    Dictionary.loadDictionary()
    |> Enum.group_by(&wordOccurrences(&1))
  end

  @doc """
    Returns all the anagrams of a given word.
  """
  @spec wordAnagrams(word) :: [word]
  def wordAnagrams(word) do
    dictionaryByOccurrences()
    |> Map.get(wordOccurrences(word))
  end

  @doc """
    Returns the list of all subsets of the occurrence list.
    This includes the occurrence itself, i.e. `List(('k', 1), ('o', 1))`
    is a subset of `List(('k', 1), ('o', 1))`.
    It also include the empty subset `List()`.
    Example: the subsets of the occurrence list `List(('a', 2), ('b', 2))` are:
      List(
        List(),
        List(('a', 1)),
        List(('a', 2)),
        List(('b', 1)),
        List(('a', 1), ('b', 1)),
        List(('a', 2), ('b', 1)),
        List(('b', 2)),
        List(('a', 1), ('b', 2)),
        List(('a', 2), ('b', 2))
      )
    Note that the order of the occurrence list subsets does not matter -- the subsets
    in the example above could have been displayed in some other order.
  """
  @spec combinations(occurences) :: [occurences]
  def combinations(occurrences) do
    case occurrences do
      [] ->
        []

      [{x1, x2}] ->
        for x <- 0..x2 do
          [{x1, x}]
        end

      [{x1, x2} | t] ->
        for x <- 0..x2,
            y <- combinations(t) do
          [{x1, x}] ++ y
        end
    end
    |> Enum.map(fn x ->
      Enum.filter(x, fn {_y1, y2} -> y2 !== 0 end)
    end)
  end

  @doc """
    Subtracts occurrence list `y` from occurrence list `x`.
    The precondition is that the occurrence list `y` is a subset of
    the occurrence list `x` -- any character appearing in `y` must
    appear in `x`, and its frequency in `y` must be smaller or equal
    than its frequency in `x`.
    Note: the resulting value is an occurrence - meaning it is sorted
    and has no zero-entries.
  """
  @spec subtract(occurences(), occurences()) :: occurences()
  def subtract(x, y) do
    case y do
      [] ->
        x

      [h | t] ->
        x
        |> Enum.filter(fn y -> y !== h end)
        |> Enum.map(fn {x1, x2} ->
          {y1, y2} = h

          case y1 == x1 do
            true -> {x1, x2 - y2}
            false -> {x1, x2}
          end
        end)
        |> subtract(t)
    end
  end

  @doc """
    Returns a list of all anagram sentences of the given sentence.
    An anagram of a sentence is formed by taking the occurrences of all the characters of
    all the words in the sentence, and producing all possible combinations of words with those characters,
    such that the words have to be from the dictionary.
    The number of words in the sentence and its anagrams does not have to correspond.
    For example, the sentence `List("I", "love", "you")` is an anagram of the sentence `List("You", "olive")`.
    Also, two sentences with the same words but in a different order are considered two different anagrams.
    For example, sentences `List("You", "olive")` and `List("olive", "you")` are different anagrams of
    `List("I", "love", "you")`.
    Here is a full example of a sentence `List("Yes", "man")` and its anagrams for our dictionary:
      List(
        List(en, as, my),
        List(en, my, as),
        List(man, yes),
        List(men, say),
        List(as, en, my),
        List(as, my, en),
        List(sane, my),
        List(Sean, my),
        List(my, en, as),
        List(my, as, en),
        List(my, sane),
        List(my, Sean),
        List(say, men),
        List(yes, man)
      )
    The different sentences do not have to be output in the order shown above - any order is fine as long as
    all the anagrams are there. Every returned word has to exist in the dictionary.
    Note: in case that the words of the sentence are in the dictionary, then the sentence is the anagram of itself,
    so it has to be returned in this list.
    Note: There is only one anagram of an empty sentence.
  """
  @spec sentenceAnagrams(sentence) :: [sentence]
  def sentenceAnagrams(sentence) do
    occs = sentenceOccurrences(sentence)

    helper(occs, dictionaryByOccurrences())
    |> Enum.filter(&(&1 !== []))
    |> Enum.map(&extractWord(&1, []))
    |> Enum.map(&extractList(&1, []))
    |> List.foldl([], fn x, acc ->
      case x do
        [h] -> [h | acc]
        [h | t] -> acc ++ x
      end
    end)
    |> Enum.filter(fn x ->
      sentenceOccurrences(List.flatten(x)) == occs
    end)
  end

  def helper(occ, dict) do
    case occ do
      [] ->
        []

      _ ->
        for comb <- combinations(occ), Map.has_key?(dict, comb),
            x <- Map.get(dict, comb) do
          case subtract(occ, comb) do
            [] ->
              # use a tuple for a marker of an constructed anagram
              [{:word, x}]

            rest ->
              for y <- helper(rest, dict), y !== [] do
                [x | [y]]
              end
          end
        end
    end
  end

  def extractWord([], acc), do: []
  def extractWord([{:word, x} | t], acc), do: [x | acc] |> Enum.reverse()
  def extractWord([[h | t]], acc), do: extractWord([h | t], acc)
  def extractWord([[h]], acc), do: extractWord([h], acc)
  def extractWord([h | t], acc) when is_list(h), do: [extractWord(h, acc) | [extractWord(t, [])]]
  def extractWord([h | t], acc) when is_list(t), do: extractWord(t, [h | acc])

  def extractList([[h | t]], acc), do: extractList([h | t], acc)
  def extractList([h | t], acc) when is_list(h), do: extractList(t, [h | acc])
  def extractList(val, acc) when val !== [], do: [val | acc] |> Enum.reverse()
end
