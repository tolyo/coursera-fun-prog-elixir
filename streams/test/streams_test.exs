defmodule StreamsTest do
  use ExUnit.Case
  doctest Streams

  defmodule Level1 do
    use StringParserTerrain

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
    with {testVector, _} <- Level1.vector() do
      terrain = Level1.terrainFunction(testVector)
      assert Block.isLegal(%Block{b1: Level1.startPos(), b2: Level1.startPos()}, terrain)
      assert Block.isLegal(%Block{b1: Level1.startPos(), b2: %Pos{row: 1, col: 2}}, terrain)
      assert not Block.isLegal(%Block{b1: %Pos{row: 0, col: 5}, b2: %Pos{row: 0, col: 6}}, terrain)
    end
  end

  test "is standing" do
    assert Block.isStanding(%Block{b1: Level1.startPos, b2: Level1.startPos})
    assert not Block.isStanding(%Block{b1: Level1.startPos, b2: %Pos{row: 1, col: 2}})
  end

  test "neighbors" do
    assert length(Block.neighbors(%Block{b1: Level1.startPos(), b2: Level1.startPos()})) === 4
  end

  test "legal neighbors" do
    with {testVector, _} <- Level1.vector() do
      terrain = Level1.terrainFunction(testVector)
      assert length(Block.legalNeighbors(%Block{b1: Level1.startPos(), b2: Level1.startPos()}, terrain)) === 2
    end
  end
end
