package week2

object lecture_2_1 {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(79); 
  println("Welcome to the Scala worksheet");$skip(134); 
  def fact(x: Int): Int = {
  	def iter(y: Int, acc: Int): Int =
  		if (y == 0) acc
  		else iter( y - 1, acc * y)
  	iter(x, 1)
  };System.out.println("""fact: (x: Int)Int""");$skip(16); val res$0 = 
  
  
  fact(3);System.out.println("""res0: Int = """ + $show(res$0))}
}
