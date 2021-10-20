package forcomp

import org.scalatest.FunSuite

import org.junit.runner.RunWith
import org.scalatest.junit.JUnitRunner

import Anagrams._

@RunWith(classOf[JUnitRunner])
class AnagramsSuite extends FunSuite {

  test("wordOccurrences: abcd") {
    assert(wordOccurrences("abcd") === List(('a', 1), ('b', 1), ('c', 1), ('d', 1)))
  }

  test("wordOccurrences: Robert") {
    assert(wordOccurrences("Robert") === List(('b', 1), ('e', 1), ('o', 1), ('r', 2), ('t', 1)))
  }

  test("sentenceOccurrences: abcd ae") {
    assert(sentenceOccurrences(List("abcd", "ae")) === List(('a', 2), ('b', 1), ('c', 1), ('d', 1), ('e', 1)))
  }
  
  test("sentenceOccurrences: ee abcde") {
    assert(sentenceOccurrences(List("ee", "abcde")) === List(('a', 1), ('b', 1), ('c', 1), ('d', 1), ('e', 3)))
  }
  
  test("sentenceOccurrences: Roberto Carlos") {
    assert(sentenceOccurrences(List("Roberto", "Carlos")) === List(('a',1), ('b',1), ('c',1), ('e',1), ('l',1), ('o',3), ('r',3), ('s',1), ('t',1)))
  }
  
  test("dictionaryByOccurrences.get: eat") {
    assert(dictionaryByOccurrences.get(List(('a', 1), ('e', 1), ('t', 1))).map(_.toSet) === Some(Set("ate", "eat", "tea")))
  }



  test("word anagrams: married") {
    assert(wordAnagrams("married").toSet === Set("married", "admirer"))
  }

  test("word anagrams: player") {
    assert(wordAnagrams("player").toSet === Set("parley", "pearly", "player", "replay"))
  }



  test("subtract: lard - r") {
    val lard = List(('a', 1), ('d', 1), ('l', 1), ('r', 1))
    val r = List(('r', 1))
    val lad = List(('a', 1), ('d', 1), ('l', 1))
    assert(subtract(lard, r) === lad)
  }
  
  test("subtract: lard - ad") {
    val lard = List(('a', 1), ('d', 1), ('l', 1), ('r', 1))
    val lr = List(('l', 1), ('r', 1))
    val ad = List(('a', 1), ('d', 1))
    assert(subtract(lard, lr) === ad)
  }
  
  test("subtract: lard - ld") {
    val lard = List(('a', 1), ('d', 1), ('l', 1), ('r', 1))
    val ld = List(('l', 1), ('d', 1))
    val ar = List(('a', 1), ('r', 1))
    assert(subtract(lard, ld) === ar)
  }



  test("combinations: []") {
    assert(combinations(Nil) === List(Nil))
  }

  test("combinations: abba") {
    val abba = List(('a', 2), ('b', 2))
    val abbacomb = List(
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
    
    assert(combinations(abba).toSet.size === abbacomb.toSet.size)
    assert(combinations(abba).toSet === abbacomb.toSet)
  }



  test("sentence anagrams: []") {
    val sentence = List()
    assert(sentenceAnagrams(sentence) === List(Nil))
  }

  test("sentence anagrams: Linux rulez") {
    val sentence = List("Linux", "rulez")
    val anas = List(
      List("Rex", "Lin", "Zulu"),
      List("nil", "Zulu", "Rex"),
      List("Rex", "nil", "Zulu"),
      List("Zulu", "Rex", "Lin"),
      List("null", "Uzi", "Rex"),
      List("Rex", "Zulu", "Lin"),
      List("Uzi", "null", "Rex"),
      List("Rex", "null", "Uzi"),
      List("null", "Rex", "Uzi"),
      List("Lin", "Rex", "Zulu"),
      List("nil", "Rex", "Zulu"),
      List("Rex", "Uzi", "null"),
      List("Rex", "Zulu", "nil"),
      List("Zulu", "Rex", "nil"),
      List("Zulu", "Lin", "Rex"),
      List("Lin", "Zulu", "Rex"),
      List("Uzi", "Rex", "null"),
      List("Zulu", "nil", "Rex"),
      List("rulez", "Linux"),
      List("Linux", "rulez")
    )
    assert(sentenceAnagrams(sentence).toSet === anas.toSet)
  }  
  
  test("breakCompound: Linuxrulez") {
    val sentence = List("Linuxrulez")
    val anas = List(List("Linux", "rulez"))
    assert(breakCompound(sentence).toSet === anas.toSet)
  }

}
