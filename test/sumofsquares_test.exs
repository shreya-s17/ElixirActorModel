defmodule SUMOFSQUARESTest do
  use ExUnit.Case
  doctest SUMOFSQUARES
  def deps do
    [{:decimal, "~> 1.0"}]
  end
  #test "one" do
   # IO.puts("Hey this is PID of server from start_link #{inspect SUMOFSQUARES.start_link()}")
  #end
  #test "two" do
   # IO.puts("Hey this  #{inspect SUMOFSQUARES.startProcess()}")
  #end
  #test "greets the world" do
   # assert SUMOFSQUARES.hello() == :world
  #end
  test "sumofsquares" do
    IO.puts("I am here")
    #IO.puts("code finished #{inspect SUMOFSQUARES.useless()}")
    #SUMOFSQUARES.bulkCalculate(1,100,2,6666)
    SUMOFSQUARES.main(10_00_00_000,24)
  end
end