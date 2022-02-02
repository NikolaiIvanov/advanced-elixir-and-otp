defmodule WordsTest do
  use ExUnit.Case
  doctest Words

  test "counts given words" do
    list = ["a", "a a a", "b a"]
    assert Words.count(list, Stream) == %{"a" => 5, "b" => 1}
  end
end
