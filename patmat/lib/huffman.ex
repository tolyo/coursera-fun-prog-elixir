defmodule Huffman do
  @moduledoc """
    Assignment 4: Huffman coding

    A huffman code is represented by a binary tree.

    Every `Leaf` node of the tree represents one character of the alphabet that the tree can encode.
    The weight of a `Leaf` is the frequency of appearance of the character.
    The branches of the huffman tree, the `Fork` nodes, represent a set containing all the characters
    present in the leaves below it. The weight of a `Fork` node is the sum of the weights of these
    leaves.
  """

  defmodule CodeTree do
    @type t :: Fork.t() | Leaf.t()
  end

  defmodule Fork do
    @type t :: %Fork{
            left: CodeTree.t(),
            right: CodeTree.t(),
            chars: [char()],
            weight: non_neg_integer()
          }
    defstruct left: nil,
              right: nil,
              chars: nil,
              weight: nil

    @spec new(CodeTree.t(), CodeTree.t(), [char()], non_neg_integer()) :: Fork.t()
    def new(left, right, chars, weight) do
      %Fork{left: left, right: right, chars: chars, weight: weight}
    end
  end

  defmodule Leaf do
    @type t :: %Leaf{
            char: char(),
            weight: non_neg_integer()
          }
    defstruct char: nil,
              weight: nil

    @spec new(char(), non_neg_integer()) :: Leaf.t()
    def new(char, weight) do
      %Leaf{char: char, weight: weight}
    end
  end

  # Part 1: Basics

  @spec weight(CodeTree.t()) :: non_neg_integer()
  def weight(tree) do
    case tree do
      %Leaf{weight: weight} -> weight
      %Fork{weight: weight} -> weight
    end
  end

  @spec chars(CodeTree.t()) :: [char()]
  def chars(tree) do
    case tree do
      %Leaf{char: char} -> [char]
      %Fork{chars: chars} -> chars
    end
  end

  @spec makeCodeTree(CodeTree.t(), CodeTree.t()) :: CodeTree.t()
  def makeCodeTree(left, right) do
    Fork.new(left, right, chars(left) ++ chars(right), weight(left) + weight(right))
  end

  # Part 2: Generating Huffman trees

  @doc """
    In this assignment, we are working with lists of characters. This function allows
    you to easily create a character list from a given string.
  """
  @spec string2Chars(String.t()) :: [char()]
  def string2Chars(str), do: str |> String.graphemes() |> Enum.map(&String.to_charlist(&1))

  @doc """
    This function computes for each unique character in the list `chars` the number of
    times it occurs. For example, the invocation

      times(['a', 'b', 'a'])

    should return the following (the order of the resulting list is not important):

      List(('a', 2), ('b', 1))

    The type `List[(Char, Int)]` denotes a list of pairs, where each pair consists of a
    character and an integer. Pairs can be constructed easily using parentheses:

      val pair: (Char, Int) = ('c', 1)

    In order to access the two elements of a pair, you can use the accessors `_1` and `_2`:

      val theChar = pair._1
      val theInt  = pair._2

    Another way to deconstruct a pair is using pattern matching:

      pair match {
          case (theChar, theInt) =>
            println("character is: "+ theChar)
            println("integer is  : "+ theInt)
        }
  """
  @spec times([char()]) :: [{char(), non_neg_integer()}]
  def times(chars) do
    case chars do
      [] ->
        []

      [h | t] ->
        count = t |> Enum.filter(fn x -> x === h end) |> length()
        [{h, count + 1} | times(Enum.filter(t, fn x -> x !== h end))]
    end
  end

  @doc """
    Returns a list of `Leaf` nodes for a given frequency table `freqs`.
    The returned list should be ordered by ascending weights (i.e. the
    head of the list should have the smallest weight), where the weight
    of a leaf is the frequency of the character.
  """
  @spec makeOrderedLeafList([{char(), non_neg_integer()}]) :: [Leaf.t()]
  def makeOrderedLeafList(freqs) do
    freqs
    |> Enum.sort_by(&elem(&1, 1))
    |> Enum.map(&Leaf.new(elem(&1, 0), elem(&1, 1)))
  end

  @doc """
    Checks whether the list `trees` contains only one single code tree.
  """
  @spec singleton([CodeTree.t()]) :: boolean()
  def singleton(trees), do: trees |> length() == 1

  @doc """
    The parameter `trees` of this function is a list of code trees ordered
    by ascending weights.
    This function takes the first two elements of the list `trees` and combines
    them into a single `Fork` node. This node is then added back into the
    remaining elements of `trees` at a position such that the ordering by weights
    is preserved.
    If `trees` is a list of less than two elements, that list should be returned
    unchanged.
  """
  @spec combine([CodeTree.t()]) :: [CodeTree.t()]
  def combine(trees) do
    case trees do
      [] -> trees
      [x] -> trees
      [x | [y]] -> [makeCodeTree(x, y)]
      [x | [y | t]] -> [makeCodeTree(x, y) | combine(t)]
    end
  end

  @doc """
    This function will be called in the following way:

      until(singleton, combine)(trees)

    where `trees` is of type `List[CodeTree]`, `singleton` and `combine` refer to
    the two functions defined above. In such an invocation, `until` should call the
    two functions until the list of code trees contains only one single tree, and
    then return that singleton list.
  """
  @spec until(([CodeTree.t()] -> boolean()), ([CodeTree.t()] -> [CodeTree.t()])) ::
          ([CodeTree.t()] -> [CodeTree.t()])
  def until(done, merge) do
    fn tree ->
      if done.(tree) do
        tree
      else
        until(done, merge).(merge.(tree))
      end
    end
  end

  @doc """
    This function creates a code tree which is optimal to encode the text `chars`.
    The parameter `chars` is an arbitrary text. This function extracts the character
    frequencies from that text and creates a code tree based on them.
  """
  @spec createCodeTree([char()]) :: CodeTree.t()
  def createCodeTree(chars) do
    until(&singleton(&1), &combine(&1)).(makeOrderedLeafList(times(chars)))
    |> List.first()
  end

  #   Part 3: Decoding
  @type bit :: integer()

  @doc """
    This function decodes the bit sequence `bits` using the code tree `tree` and returns
    the resulting list of characters.
  """
  @spec decode(CodeTree.t(), [bit]) :: [char()]
  def decode(tree, bits) do
    decode_helper(tree, bits, tree, bits)
  end

  defp decode_helper(tree, bits, remaining_tree, remaining_bits) do
    case remaining_tree do
      %Leaf{} ->
        case remaining_bits do
          [] -> [remaining_tree.char]
          [h | t] -> [remaining_tree.char | decode_helper(tree, bits, tree, remaining_bits)]
        end

      %Fork{} ->
        case remaining_bits do
          [0 | t] -> decode_helper(tree, bits, remaining_tree.left, t)
          [1 | t] -> decode_helper(tree, bits, remaining_tree.right, t)
        end
    end
  end

  @doc """
    A Huffman coding tree for the French language.
    Generated from the data given at
      http://fr.wikipedia.org/wiki/Fr%C3%A9quence_d%27apparition_des_lettres_en_fran%C3%A7ais
  """
  @spec frenchCode() :: CodeTree.t()
  def frenchCode(), do: FrenchCode.get()

  @doc """
    What does the secret message say? Can you decode it?
    For the decoding use the `frenchCode' Huffman tree defined above.
  """
  @spec secret() :: [bit()]
  def secret(), do: FrenchCode.secret()

  @doc """
    Write a function that returns the decoded secret
  """
  @spec decodedSecret() :: [char()]
  def decodedSecret() do
    decode(frenchCode(), secret())
  end

  # Part 4a: Encoding using Huffman tree

  @doc """
    This function encodes `text` using the code tree `tree`
    into a sequence of bits.
  """
  @spec encode(CodeTree.t()) :: ([char] -> [bit()])
  def encode(tree) do
    fn chars ->
      chars
      |> Enum.map(fn x -> encodeChar(tree, x) end)
      |> List.flatten()
    end
  end

  @spec encodeChar(CodeTree.t(), char()) :: [bit]
  def encodeChar(tree, c) do
    case tree do
      %Leaf{} ->
        []

      %Fork{} ->
        if Enum.any?(chars(tree.left), &(&1 == c)) do
          [0 | encodeChar(tree.left, c)]
        else
          [1 | encodeChar(tree.right, c)]
        end
    end
  end

  #   Part 4b: Encoding using code table

  defmodule CodeTable do
    @type t :: [{char(), [Huffman.bit()]}]
  end

  @doc """
    This function returns the bit sequence that represents the character `char` in
    the code table `table`.
  """
  @spec codeBits(CodeTable.t()) :: (char() -> [bit])
  def codeBits(table) do
    fn char ->
      case Enum.find(table, fn x -> elem(x, 0) == char end) do
        nil -> []
        val -> elem(val, 1)
      end
    end
  end

  @doc """
    Given a code tree, create a code table which contains, for every character in the
    code tree, the sequence of bits representing that character.

    Hint: think of a recursive solution: every sub-tree of the code tree `tree` is itself
    a valid code tree that can be represented as a code table. Using the code tables of the
    sub-trees, think of how to build the code table for the entire tree.
  """
  @spec convert(CodeTree.t()) :: CodeTable.t()
  def convert(tree) do
    convert_tree_helper(tree, tree)
  end

  defp convert_tree_helper(original_tree, tree) do
    case tree do
      %Fork{} ->
        mergeCodeTables(convert(tree.left), convert(tree.right))

      %Leaf{} ->
        bits = encode(original_tree).([tree.char])
        [{tree.char, bits}]
    end
  end

  @doc """
    This function takes two code tables and merges them into one. Depending on how you
    use it in the `convert` method above, this merge method might also do some transformations
    on the two parameter code tables.
  """
  @spec mergeCodeTables(CodeTable.t(), CodeTable.t()) :: CodeTable.t()
  def mergeCodeTables(a, b) do
    case a do
      [] -> Enum.map(b, fn x -> {elem(x, 0), elem(x, 1) ++ [1]} end)
      [x] -> [{elem(x, 0), elem(x, 1) ++ [0]}] ++ mergeCodeTables([], b)
      [x | t] -> [{elem(x, 0), elem(x, 1) ++ [0]}] ++ mergeCodeTables(t, b)
    end
  end

  @doc """
    This function encodes `text` according to the code tree `tree`.
    To speed up the encoding process, it first converts the code tree to a code table
    and then uses it to perform the actual encoding.
  """
  @spec quickEncode(CodeTree.t()) :: ([char()] -> [bit()])
  def quickEncode(tree) do
    fn text ->
      text
      |> Enum.map(fn x -> codeBits(convert(tree)).(x) end)
      |> List.flatten()
    end
  end
end
