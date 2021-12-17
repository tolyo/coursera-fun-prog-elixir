defmodule StreamsTest do
  use ExUnit.Case
  doctest Streams

  test "greets the world" do
    assert Streams.hello() == :world
  end
end
