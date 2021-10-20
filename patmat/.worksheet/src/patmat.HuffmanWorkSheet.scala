package patmat
import patmat.Huffman._

object HuffmanWorkSheet {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(109); 
  println("Welcome to the Scala worksheet");$skip(63); 
	
	
	val t1 = Fork(Leaf('a',2), Leaf('b',3), List('a','b'), 5);System.out.println("""t1  : patmat.Huffman.Fork = """ + $show(t1 ));$skip(11); val res$0 = 
	t1.weight;System.out.println("""res0: Int = """ + $show(res$0))}
}
