defmodule SUMOFSQUARES do
  @moduledoc """
  Documentation for SUMOFSQUARES.
  """

  @doc """
  Hello world.

  ## Examples

      iex> SUMOFSQUARES.hello()
      :world

  """
  def hello do
    :world
  end
  def calculateSum(n,counter) do
    abc = self()
    #IO.puts("hello 1 #{inspect abc}")
    if(counter == 1) do
      n
    else
    n+calculateSum(n-1,counter-1)
    end
  end
  def sendValues do
    parent=self()
    spawn fn -> send parent, {:ans, calculateSum(10,10)} end
    IO.puts("hey")
    spawn fn -> send parent, {:ans, calculateSum(20,10)} end
    IO.puts("hey1")
    spawn fn -> send parent, {:ans, calculateSum(30,10)} end
    IO.puts("hey92")
    spawn fn -> send parent, {:ans, calculateSum(40,10)} end
    spawn fn -> send parent, {:ans, calculateSum(50,10)} end

    (collect([],5)) |> Enum.reduce(&(&1+&2))

    #IO.puts(" hello #{inspect parent}")
  end
  def collect(list,counter) do
    if(counter ==0) do
    list
  else
    receive do
      {:ans, value} -> collect([value|list], counter-1)
    end
  end

  end
end
