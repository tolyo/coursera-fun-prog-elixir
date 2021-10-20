package streams

import org.scalatest.FunSuite

import org.junit.runner.RunWith
import org.scalatest.junit.JUnitRunner

import Bloxorz._

@RunWith(classOf[JUnitRunner])
class BloxorzSuite extends FunSuite {

  trait SolutionChecker extends GameDef with Solver with StringParserTerrain {
    /**
     * This method applies a list of moves `ls` to the block at position
     * `startPos`. This can be used to verify if a certain list of moves
     * is a valid solution, i.e. leads to the goal.
     */
    def solve(ls: List[Move]): Block =
      ls.foldLeft(startBlock) { case (block, move) => move match {
        case Left => block.left
        case Right => block.right
        case Up => block.up
        case Down => block.down
      }
    }
  }

  trait Level1 extends SolutionChecker {
      /* terrain for level 1*/

    val level =
    """ooo-------
      |oSoooo----
      |ooooooooo-
      |-ooooooooo
      |-----ooToo
      |------ooo-""".stripMargin

    val optsolution = List(Right, Right, Down, Right, Right, Right, Down)
    
    val level2 =
	    """ST
			|oo
			|oo""".stripMargin
  }

  test("findChar level 1") {
    new Level1 {
      assert(startPos == Pos(1,1))
    }
  }

  test("optimal solution for level 1") {
    new Level1 {
      assert(solve(solution) == Block(goal, goal))
    }
  }

  test("optimal solution length for level 1") {
    new Level1 {
      assert(solution.length == optsolution.length)
    }
  }
  
  test("terrainFunction function"){
    new Level1 {
    	val testVector = Vector(Vector('S', 'T'), Vector('-', 'o'), Vector('o', 'o'))
    	val func = terrainFunction(testVector)
    	assert(func(Pos(0,0)) === true)
    	assert(func(Pos(-1,-1)) === false)
    	assert(func(Pos(4,4)) === false)
    	assert(func(Pos(1,0)) === false)
    	assert(func(Pos(1,1)) === true)
    }
  }
  
  test("findChar function"){
    new Level1{
    	val testVector = Vector(Vector('S', 'T'), Vector('-', 'o'), Vector('o', 'o'))
    	assert(findChar('S', testVector) === Pos(0,0))
    	assert(findChar('T', testVector) === Pos(0,1))
    }
  }
  
  test("is standing"){
    new Level1{
      assert(Block(startPos, startPos).isStanding)
      assert(!Block(startPos, Pos(1,2)).isStanding)
    }
  }
  
  test("is legal"){
    new Level1{
      assert(Block(startPos, startPos).isLegal)
      assert(Block(startPos, Pos(1,2)).isLegal)
      assert(!Block(Pos(0,5), Pos(0,6)).isLegal)
    }
  }
  
  test("neighbors"){
    new Level1{
      assert(Block(startPos, startPos).neighbors.size === 4)
    }
  }
  
  test("legal neighbors"){
    new Level1{
      assert(Block(startPos, startPos).legalNeighbors.size === 2)
    }
  }
  
  test("done"){
    new Level1{
      assert(done(Block(goal, goal)))
      assert(!done(Block(Pos(1,1), Pos(1,1))))
    }
  }
  
  test("neighbors with history"){
    new Level1{
    	val result = neighborsWithHistory(Block(Pos(1,1),Pos(1,1)), List(Left,Up))
    	val testSet = Set(
		  (Block(Pos(1,2),Pos(1,3)), List(Right,Left,Up)),
		  (Block(Pos(2,1),Pos(3,1)), List(Down,Left,Up))
		)
    	assert(result.toSet === testSet)
    }
  }
  
  test("new neighbors only"){
    new Level1{
      val result = newNeighborsOnly(
		  Set(
		    (Block(Pos(1,2),Pos(1,3)), List(Right,Left,Up)),
		    (Block(Pos(2,1),Pos(3,1)), List(Down,Left,Up))
		  ).toStream,
		
		  Set(Block(Pos(1,2),Pos(1,3)), Block(Pos(1,1),Pos(1,1)))
		)
		
	  val testResult = Set(
	    (Block(Pos(2,1),Pos(3,1)), List(Down,Left,Up))
	  ).toStream
	  
	  assert(result === testResult)
    }
  }
}
