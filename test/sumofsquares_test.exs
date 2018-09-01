defmodule SUMOFSQUARESTest do
  use ExUnit.Case
  doctest SUMOFSQUARES

  test "greets the world" do
    assert SUMOFSQUARES.hello() == :world
  end
  test "sumofsquares" do
    IO.puts(SUMOFSQUARES.sendValues())
  end
end
