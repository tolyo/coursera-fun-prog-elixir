package patmat

import org.scalatest.FunSuite

import org.junit.runner.RunWith
import org.scalatest.junit.JUnitRunner

import patmat.Huffman._

@RunWith(classOf[JUnitRunner])
class HuffmanSuite extends FunSuite {
  trait TestTrees {
    val t1 = Fork(Leaf('a',2), Leaf('b',3), List('a','b'), 5)
    val t2 = Fork(Fork(Leaf('a',2), Leaf('b',3), List('a','b'), 5), Leaf('d',4), List('a','b','d'), 9)
  }

  test("weight of a larger tree") {
    new TestTrees {
      assert(weight(t1) === 5)
    }
  }

  test("chars of a larger tree") {
    new TestTrees {
      assert(chars(t2) === List('a','b','d'))
    }
  }

  test("string2chars(\"hello, world\")") {
    assert(string2Chars("hello, world") === List('h', 'e', 'l', 'l', 'o', ',', ' ', 'w', 'o', 'r', 'l', 'd'))
  }
  
  test("times"){
    assert(times("test".toList) === List(('t', 2), ('e', 1), ('s', 1)))
  }

  test("makeOrderedLeafList for some frequency table") {
    assert(makeOrderedLeafList(List(('t', 2), ('e', 1), ('x', 3))) === List(Leaf('e',1), Leaf('t',2), Leaf('x',3)))
  }
  
  test("singleton"){
    assert(singleton(List(Leaf('e', 1))) == true)
    assert(singleton(Nil) == false)
  }
  
  test("combine of some leaf list") {
    val leaflist = List(Leaf('e', 1), Leaf('t', 2), Leaf('x', 4))
    assert(combine(leaflist) === List(Fork(Leaf('e',1),Leaf('t',2),List('e', 't'),3), Leaf('x',4)))
  }
  
  test("until(singleton, combine)(trees)"){
    val trees = List(Leaf('e', 1), Leaf('t', 2))
    assert(until(singleton, combine)(trees) === List(Fork(Leaf('e',1),Leaf('t',2),List('e', 't'),3)))
  }
  
  test("create code tree") {
	  assert(createCodeTree(string2Chars("tet")) == Fork(Leaf('e',1),Leaf('t',2),List('e', 't'),3))
  }
  
  test("decode"){
    new TestTrees {
	  assert(decode(t1, List(0, 1)) === List('a', 'b')) 
    }
  }
  
  test("decode and encode a very short text should be identity") {
    new TestTrees {
      assert(decode(t1, encode(t1)("abbabb".toList)) === "abbabb".toList)
      assert(encode(frenchCode)(decodedSecret) === secret)
    }
  }
  
  test("decode and quick a very short text should be identity") {
    new TestTrees {
      assert(quickEncode(t1)("abab".toList) === List(0, 1, 0, 1))
    }
  }
  
  test("codebits") {
    val codeList = List(('a', List(1,2)))
    assert(codeBits(codeList)('a') == List(1,2))
  }
  
  test("convert") {
    new TestTrees {
      assert(convert(t1) === List(('a', List(0)), ('b', List(1))))
    }
  }
  
  test("merge") {
    val a = List(('a', List(0)))
    val b = List(('a', List(0)))
    assert(mergeCodeTables(a, b) === List(('a', List(0,0)), ('a', List(0,1))))    
  }
}
