defmodule InspectableTest do
  use ExUnit.Case
  doctest Inspectable

  test "greets the world" do
    assert Inspectable.hello() == :world
  end
end
