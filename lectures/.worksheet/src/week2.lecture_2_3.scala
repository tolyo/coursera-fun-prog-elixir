package week2

object lecture_2_3 {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(79); 
  println("Welcome to the Scala worksheet");$skip(114); 
  
  def product(f: Int => Int)( a: Int, b: Int): Int = {
  	if (a > b) 1
  	else f(a) * product(f)(a + 1, b)
  };System.out.println("""product: (f: Int => Int)(a: Int, b: Int)Int""");$skip(24); val res$0 = 
  product(x => x)(1, 3);System.out.println("""res0: Int = """ + $show(res$0));$skip(51); 
  
  def fact(x: Int): Int = product(x => x)(1, x);System.out.println("""fact: (x: Int)Int""");$skip(13); val res$1 = 
	
	
	fact(3);System.out.println("""res1: Int = """ + $show(res$1))}
	
}
