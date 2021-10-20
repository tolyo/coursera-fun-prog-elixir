package week2

object lecture_2_2 {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet
  
  def sum(f: Int => Int, a: Int, b: Int): Int = {
  	def loop(a: Int, acc: Int): Int = {
  		if (a > b) acc
  		else loop(a + 1, acc + f(a))
  	}
  	loop(a,0)
  }                                               //> sum: (f: Int => Int, a: Int, b: Int)Int
  sum(x => x + x, 2, 4)                           //> res0: Int = 18
  
}