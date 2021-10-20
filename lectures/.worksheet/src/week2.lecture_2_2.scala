package week2

object lecture_2_2 {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(79); 
  println("Welcome to the Scala worksheet");$skip(166); 
  
  def sum(f: Int => Int, a: Int, b: Int): Int = {
  	def loop(a: Int, acc: Int): Int = {
  		if (a > b) acc
  		else loop(a + 1, acc + f(a))
  	}
  	loop(a,0)
  };System.out.println("""sum: (f: Int => Int, a: Int, b: Int)Int""");$skip(24); val res$0 = 
  sum(x => x + x, 2, 4);System.out.println("""res0: Int = """ + $show(res$0))}
  
}
