defmodule CalculatorSupTest do
  use ExUnit.Case
  doctest CalculatorSup

  test "greets the world" do
    assert CalculatorSup.hello() == :world
  end
end
