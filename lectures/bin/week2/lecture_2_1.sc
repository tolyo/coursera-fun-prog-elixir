package week2

object lecture_2_1 {
  println("Welcome to the Scala worksheet")
  def fact(x: Int): Int = {
  	def iter(y: Int, acc: Int): Int =
  		if (y == 0) acc
  		else iter( y - 1, acc * y)
  	iter(x, 1)
  }
  
  
  fact(3)
}