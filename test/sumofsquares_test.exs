defmodule SUMOFSQUARESTest do
  use ExUnit.Case
  doctest SUMOFSQUARES
  def deps do
    [{:decimal, "~> 1.0"}]
  end
  test "sumofsquares" do
    IO.puts("I am here")
    #SUMOFSQUARES.spawnTwoMachines()
    SUMOFSQUARES.main(40,24)
  end
end