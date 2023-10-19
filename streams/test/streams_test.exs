defmodule StreamsTest do
  use ExUnit.Case
  doctest Streams

  # This method applies a list of moves `ls` to the block at position
  # `startPos`. This can be used to verify if a certain list of moves
  # is a valid solution, i.e. leads to the goal.
  defmodule SolutionChecker do
    defmacro __using__(_opts) do
      quote do
        @spec solve(%Pos{}, [Move.t()]) :: Block.t()
        def solve(block, moves) do
          Enum.reduce(moves, block, fn move, acc ->
            case move do
              :left -> Block.left(acc)
              :right -> Block.right(acc)
              :up -> Block.up(acc)
              :down -> Block.down(acc)
            end
          end)
        end
      end
    end
  end

  defmodule Level1 do
    use StringParserTerrain
    use SolutionChecker

    @spec level :: String.t()
    def level,
      do: """
        ooo-------
        ooSoooo----
        ooooooooo-
        -ooooooooo
        -----ooToo
        ------ooo-
      """

    def vector, do: vector(level())

    def startPos, do: startPos(vector())
  end

  describe "bloxzor" do
    test "findChar level 1" do
      with {pos, _} <- Level1.startPos() do
        assert pos == %Pos{row: 1, col: 1}
      end
    end
  end

  test "terrainFunction function" do
    with {testVector, _} <- Level1.vector() do
      func = Level1.terrainFunction(testVector)
      assert func.(%Pos{row: 0, col: 0}) === true
      assert func.(%Pos{row: -1, col: -1}) === false
      assert func.(%Pos{row: 4, col: 4}) === false
      assert func.(%Pos{row: 1, col: 0}) === false
      assert func.(%Pos{row: 1, col: 1}) === true
    end
  end

  test "findChar function" do
    with {testVector, _} <- Level1.vector() do
      assert Level1.findChar(~c"S", testVector) === %Pos{row: 0, col: 0}
      assert Level1.findChar(~c"T", testVector) === %Pos{row: 0, col: 1}
    end
  end

  test "is legal" do
    assert Block.isLegal(%Block{b1: Level1.startPos(), b2: Level1.startPos()})
    assert Block.isLegal(%Block{b1: Level1.startPos(), b2: %Pos{row: 1, col: 2}})
    assert not Block.isLegal(%Block{b1: %Pos{row: 0, col: 5}, b2: %Pos{row: 0, col: 6}})
  end

  test "neighbors" do
    assert length(Block.neighbors(%Block{b1: Level1.startPos(), b2: Level1.startPos()})) === 4
  end

  test "legal neighbors" do
    assert length(Block.legalNeighbors(%Block{b1: Level1.startPos(), b2: Level1.startPos()})) === 2
  end
end
