package forcomp
import forcomp.Anagrams._

object AnagramsWorksheet {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(113); 
  println("Welcome to the Scala worksheet");$skip(23); 

  val greet = "Hello";System.out.println("""greet  : String = """ + $show(greet ));$skip(36); 
  val greeter = greet.toList.sorted;System.out.println("""greeter  : List[Char] = """ + $show(greeter ));$skip(41); 
  var result = greeter groupBy(_ == 'e');System.out.println("""result  : scala.collection.immutable.Map[Boolean,List[Char]] = """ + $show(result ));$skip(25); val res$0 = 
	
	result contains(true);System.out.println("""res0: Boolean = """ + $show(res$0));$skip(24); val res$1 = 
	result contains(false);System.out.println("""res1: Boolean = """ + $show(res$1))}
}
