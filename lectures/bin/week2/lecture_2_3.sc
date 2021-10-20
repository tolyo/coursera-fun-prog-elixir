package week2

object lecture_2_3 {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet
  
  def product(f: Int => Int)( a: Int, b: Int): Int = {
  	if (a > b) 1
  	else f(a) * product(f)(a + 1, b)
  }                                               //> product: (f: Int => Int)(a: Int, b: Int)Int
  product(x => x)(1, 3)                           //> res0: Int = 6
  
  def fact(x: Int): Int = product(x => x)(1, x)   //> fact: (x: Int)Int
	
	
	fact(3)                                   //> res1: Int = 6
	
}