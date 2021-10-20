package week1

object lecture_1_56 {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(209); 
	
	def abs(x: Double) = if (x < 0) -x else

  def sqrtIter(guess: Double, x: Double): Double =
    if (isGoodEnough(guess, x)) guess
    else sqrtIter(improve(guess, x), x);System.out.println("""abs: (x: Double)Any""");$skip(84); 
		
	def isGoodEnough(guess: Double, x: Double) =
		abs(guess * guess - x)/x < 0.001;System.out.println("""isGoodEnough: (guess: Double, x: Double)<error>""");$skip(69); 
	
	def improve(guess: Double, x: Double) =
		(guess + x / guess) / 2;System.out.println("""improve: (guess: Double, x: Double)Double""");$skip(43); 
		
	def sqrt(x: Double) = sqrtIter(1.0, x);System.out.println("""sqrt: (x: Double)<error>""");$skip(11); val res$0 = 
	
	sqrt(2);System.out.println("""res0: <error> = """ + $show(res$0));$skip(9); val res$1 = 
	sqrt(4);System.out.println("""res1: <error> = """ + $show(res$1));$skip(12); val res$2 = 
	sqrt(1e-6);System.out.println("""res2: <error> = """ + $show(res$2));$skip(12); val res$3 = 
	sqrt(1e60);System.out.println("""res3: <error> = """ + $show(res$3))}
	
}
