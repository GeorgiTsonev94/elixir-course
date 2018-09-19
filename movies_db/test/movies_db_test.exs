defmodule MoviesDbTest do
  use ExUnit.Case
  doctest MoviesDb

  test "greets the world" do
    assert MoviesDb.hello() == :world
  end
end
