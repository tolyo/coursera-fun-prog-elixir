defmodule ForcompTest do
  use ExUnit.Case
  import Anagrams

  test "wordOccurrences: abcd" do
    assert wordOccurrences("abcd") === [{'a', 1}, {'b', 1}, {'c', 1}, {'d', 1}]
  end

  test "wordOccurrences: Robert" do
    assert wordOccurrences("Robert") === [{'b', 1}, {'e', 1}, {'o', 1}, {'r', 2}, {'t', 1}]
  end

  test "sentenceOccurrences: abcd ae" do
    assert sentenceOccurrences(["abcd", "ae"]) === [
             {'a', 2},
             {'b', 1},
             {'c', 1},
             {'d', 1},
             {'e', 1}
           ]
  end

  test "sentenceOccurrences: ee abcde" do
    assert sentenceOccurrences(["ee", "abcde"]) === [
             {'a', 1},
             {'b', 1},
             {'c', 1},
             {'d', 1},
             {'e', 3}
           ]
  end

  test "sentenceOccurrences: Roberto Carlos" do
    assert sentenceOccurrences(["Roberto", "Carlos"]) === [
             {'a', 1},
             {'b', 1},
             {'c', 1},
             {'e', 1},
             {'l', 1},
             {'o', 3},
             {'r', 3},
             {'s', 1},
             {'t', 1}
           ]
  end

  test "dictionaryByOccurrences.get: eat" do
    %{[{'a', 1}, {'e', 1}, {'t', 1}] => x} = dictionaryByOccurrences()
    assert x === ["ate", "eat", "tea"]
  end

  test "word anagrams: married" do
    wordAnagrams("married")
    |> Enum.each(fn x ->
      assert Enum.member?(["married", "admirer"], x)
    end)
  end

  test "word anagrams: player" do
    wordAnagrams("player")
    |> Enum.each(fn x ->
      assert Enum.member?(["parley", "pearly", "player", "replay"], x)
    end)
  end
end
