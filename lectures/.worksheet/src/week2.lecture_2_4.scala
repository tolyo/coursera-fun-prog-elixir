package week2

object lecture_2_4 {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(60); 
  val tolerance = 0.0001;System.out.println("""tolerance  : Double = """ + $show(tolerance ));$skip(79); 
  
  def isCloseEnough(x: Double, y: Double) = math.abs((x-y)/x)/x < tolerance;System.out.println("""isCloseEnough: (x: Double, y: Double)Boolean""");$skip(260); 
  	
  def fixedPoint(f: Double => Double)(firstGuess: Double) = {
  	def iterate(guess: Double): Double = {
  		println("guess = " + guess)
  		val next = f(guess)
  		if (isCloseEnough(guess, next)) next
  		else iterate(next)
  	}
  	iterate(firstGuess)
  };System.out.println("""fixedPoint: (f: Double => Double)(firstGuess: Double)Double""");$skip(32); val res$0 = 
  
  fixedPoint(x => 1+ x/2)(1);System.out.println("""res0: Double = """ + $show(res$0));$skip(67); 

	def averageDamp(f: Double => Double)(x: Double) = (x + f(x)) / 2;System.out.println("""averageDamp: (f: Double => Double)(x: Double)Double""");$skip(68); 
  
	def sqrt(x: Double) =
		fixedPoint(averageDamp(y =>  x / y))(1);System.out.println("""sqrt: (x: Double)Double""");$skip(11); val res$1 = 
	
	sqrt(2);System.out.println("""res1: Double = """ + $show(res$1))}
                                                  
}
