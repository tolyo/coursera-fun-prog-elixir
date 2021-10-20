package week3

object lectures_3_1 {

	val x = new Rational(4, 2)                //> x  : week3.Rational = 2/1
	val y = new Rational(4,2)                 //> y  : week3.Rational = 2/1
	x + y                                     //> res0: week3.Rational = 4/1
}

class Rational(x: Int, y: Int) {

	//require(y != 0, "denominator must be nonzero")

	//def this(x: Int) = this(x, 1)
	
	private def gcd(a: Int, b: Int): Int = if (b == 0) a else gcd(b, a%b)
	private val g = gcd(x, y)
		
	val numer = x / g
	val denom = y / g
	
	def less(that: Rational) = numer * that.denom < that.numer * denom

	def < (that: Rational) = this less that
	
	def max(that: Rational) = if (this less that) that else this
	
			
	def addRational(r: Rational, s: Rational) {
		new Rational(
			r.numer * s.denom + s.numer * r.denom,
		 	s.denom * r.denom)
	}
	
	def makeString(r: Rational) =
		r.numer+ "/" + r.denom
	
	
	def add(that: Rational) =
		new Rational(numer * that.denom + that.numer * denom, denom * that.denom)
	
	def + (that: Rational) = this add that
	
	def neg: Rational = new Rational(-numer, denom)
	
	def unary_- : Rational = this neg
	
	def - (that: Rational) = this + -that
	
	def subtract(that: Rational): Rational = add(that neg)
	
	override def toString = makeString(this)

}