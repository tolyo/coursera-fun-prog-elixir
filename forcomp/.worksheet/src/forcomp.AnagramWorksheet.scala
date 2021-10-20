package forcomp

object AnagramWorksheet {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(86); 
  println("Welcome to the Scala worksheet");$skip(21); 
  val test = "wordw";System.out.println("""test  : String = """ + $show(test ));$skip(43); 
  val group = test groupBy (x => x == 'w');System.out.println("""group  : scala.collection.immutable.Map[Boolean,String] = """ + $show(group ));$skip(17); val res$0 = 
  
  group(true);System.out.println("""res0: String = """ + $show(res$0))}
}
