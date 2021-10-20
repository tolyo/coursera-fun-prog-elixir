package forcomp
import forcomp.Anagrams._

object AnagramsWorksheet {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet

  val greet = "Hello"                             //> greet  : String = Hello
  val greeter = greet.toList.sorted               //> greeter  : List[Char] = List(H, e, l, l, o)
  var result = greeter groupBy(_ == 'e')          //> result  : scala.collection.immutable.Map[Boolean,List[Char]] = Map(false -> 
                                                  //| List(H, l, l, o), true -> List(e))
	
	result contains(true)                     //> res0: Boolean = true
	result contains(false)                    //> res1: Boolean = true
}