package forcomp

object AnagramWorksheet {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet
  val test = "wordw"                              //> test  : String = wordw
  val group = test groupBy (x => x == 'w')        //> group  : scala.collection.immutable.Map[Boolean,String] = Map(false -> ord, 
                                                  //| true -> ww)
  
  group(true)                                     //> res0: String = ww
}