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
    IO.puts("I am here #{inspect SUMOFSQUARES.sendValues(0,10000000,2)}")
  end
end