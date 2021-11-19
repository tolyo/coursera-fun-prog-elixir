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

  test "combinations: []" do
    assert combinations([]) === []
  end

  test "combinations: abba" do
    abba = [{'a', 2}, {'b', 2}]

    abbacomb = [
      [],
      [{'a', 1}],
      [{'a', 2}],
      [{'b', 1}],
      [{'a', 1}, {'b', 1}],
      [{'a', 2}, {'b', 1}],
      [{'b', 2}],
      [{'a', 1}, {'b', 2}],
      [{'a', 2}, {'b', 2}]
    ]

    assert combinations(abba) |> length === abbacomb |> length

    combinations(abba)
    |> Enum.each(fn x ->
      assert Enum.member?(abbacomb, x)
    end)
  end

  test "subtract: lard - r" do
    lard = [{'a', 1}, {'d', 1}, {'l', 1}, {'r', 1}]
    r = [{'r', 1}]
    lad = [{'a', 1}, {'d', 1}, {'l', 1}]
    assert subtract(lard, r) === lad
  end

  test "subtract: lard - ad" do
    lard = [{'a', 1}, {'d', 1}, {'l', 1}, {'r', 1}]
    lr = [{'l', 1}, {'r', 1}]
    ad = [{'a', 1}, {'d', 1}]
    assert subtract(lard, lr) === ad
  end

  test "subtract: lard - ld" do
    lard = [{'a', 1}, {'d', 1}, {'l', 1}, {'r', 1}]
    ld = [{'l', 1}, {'d', 1}]
    ar = [{'a', 1}, {'r', 1}]
    assert subtract(lard, ld) === ar
  end

  test "subtract: llard - ld" do
    llard = [{'a', 1}, {'d', 1}, {'l', 2}, {'r', 1}]
    ld = [{'l', 1}, {'d', 1}]
    ar = [{'a', 1}, {'l', 1}, {'r', 1}]
    assert subtract(llard, ld) === ar
  end

  test "sentence anagrams: []" do
    assert sentenceAnagrams([]) === []
  end

  test "sentence anagrams: Linux rulez" do
    sentence = ["Linux", "rulez"]

    anas = [
      ["Rex", "Lin", "Zulu"],
      ["nil", "Zulu", "Rex"],
      ["Rex", "nil", "Zulu"],
      ["Zulu", "Rex", "Lin"],
      ["null", "Uzi", "Rex"],
      ["Rex", "Zulu", "Lin"],
      ["Uzi", "null", "Rex"],
      ["Rex", "null", "Uzi"],
      ["null", "Rex", "Uzi"],
      ["Lin", "Rex", "Zulu"],
      ["nil", "Rex", "Zulu"],
      ["Rex", "Uzi", "null"],
      ["Rex", "Zulu", "nil"],
      ["Zulu", "Rex", "nil"],
      ["Zulu", "Lin", "Rex"],
      ["Lin", "Zulu", "Rex"],
      ["Uzi", "Rex", "null"],
      ["Zulu", "nil", "Rex"],
      ["rulez", "Linux"],
      ["Linux", "rulez"]
    ]

    assert sentenceAnagrams(sentence) != []

    sentenceAnagrams(sentence)
    |> Enum.each(fn x ->
      assert Enum.member?(anas, x)
    end)
  end
end
