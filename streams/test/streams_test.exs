defmodule StreamsTest do
  use ExUnit.Case
  doctest Streams

  describe "bloxzor" do
    test "findChar level 1" do
      pos = Level1.startPos()
      assert pos == %Pos{row: 1, col: 1}
    end
  end

  test "terrainFunction function" do
    with {testVector, _} <- Level1.vector() do
      func = StringParserTerrain.terrainFunction(testVector)
      assert func.(%Pos{row: 0, col: 0}) === true
      assert func.(%Pos{row: -1, col: -1}) === false
      assert func.(%Pos{row: 4, col: 4}) === false
      assert func.(%Pos{row: 1, col: 0}) === false
      assert func.(%Pos{row: 1, col: 1}) === true
    end
  end

  test "findChar function" do
    level =
      """
      ST
      -o
      oo
      """

    testVector = StringParserTerrain.vector(level)
    assert StringParserTerrain.findChar("S", testVector) == %Pos{row: 0, col: 0}
    assert StringParserTerrain.findChar("T", testVector) == %Pos{row: 0, col: 1}
  end

  test "is legal" do
    terrain = Level1.terrain()
    assert Block.isLegal(%Block{b1: Level1.startPos(), b2: Level1.startPos()}, terrain)
    assert Block.isLegal(%Block{b1: Level1.startPos(), b2: %Pos{row: 1, col: 2}}, terrain)

    assert not Block.isLegal(
             %Block{b1: %Pos{row: 10, col: 8}, b2: %Pos{row: 10, col: 9}},
             terrain
           )
  end

  test "is standing" do
    assert Block.isStanding(%Block{b1: Level1.startPos(), b2: Level1.startPos()})
    assert not Block.isStanding(%Block{b1: Level1.startPos(), b2: %Pos{row: 1, col: 2}})
  end

  test "neighbors" do
    assert length(Block.neighbors(%Block{b1: Level1.startPos(), b2: Level1.startPos()})) === 4
  end

  test "legal neighbors" do
    terrain = Level1.terrain()

    assert length(
             Block.legalNeighbors(%Block{b1: Level1.startPos(), b2: Level1.startPos()}, terrain)
           ) === 2
  end

  test "done" do
    assert Level1.done(%Block{b1: Level1.goal(), b2: Level1.goal()})
    assert not Level1.done(%Block{b1: %Pos{row: 1, col: 1}, b2: %Pos{row: 1, col: 1}})
  end

  test "neighbors with history" do
    result =
      Level1.neighborsWithHistory(
        %Block{b1: %Pos{row: 1, col: 1}, b2: %Pos{row: 1, col: 1}},
        [:left, :up]
      )
      |> Enum.to_list()

    test_set = [
      {%Block{b1: %Pos{row: 1, col: 2}, b2: %Pos{row: 1, col: 3}}, [:right, :left, :up]},
      {%Block{b1: %Pos{row: 2, col: 1}, b2: %Pos{row: 3, col: 1}}, [:down, :left, :up]}
    ]

    assert length(result) === 2
    assert result == test_set
  end

  test "new neighbors only" do
    neighbors =
      [
        {%Block{b1: %Pos{row: 1, col: 2}, b2: %Pos{row: 1, col: 3}}, [:right, :left, :up]},
        {%Block{b1: %Pos{row: 2, col: 1}, b2: %Pos{row: 3, col: 1}}, [:down, :left, :up]}
      ]

    explored =
      MapSet.new([
        %Block{b1: %Pos{row: 1, col: 2}, b2: %Pos{row: 1, col: 3}},
        %Block{b1: %Pos{row: 1, col: 1}, b2: %Pos{row: 1, col: 1}}
      ])

    result = Level1.newNeighborsOnly(neighbors, explored) |> Enum.to_list()

    test_result = [
      {%Block{b1: %Pos{row: 2, col: 1}, b2: %Pos{row: 3, col: 1}}, [:down, :left, :up]}
    ]

    assert result === test_result
  end
end
