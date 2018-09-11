defmodule SUMOFSQUARES do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__ ,[])
  end

  #---------------------- Server callbacks ----------------------#

  def handle_cast({:result,value},state) do
  # Collecting values in a list which are satisfy elliptic curve theory 
    {:noreply, [value | state]}
  end
  

  def handle_call(:result,_from,state) do
  # Calling the server to find the consoldiated list of values satisfying requirement
    {:reply,state,state}
  end


  def init(args) do
  # Initializing list to empty
    {:ok, args}
  end


  #------------------------ Client - side -----------------#

  def main(n,k) do

    # Start the server and get its process id
    {:ok,pid}=SUMOFSQUARES.start_link

    # This method is used for spawning multiple processes where batch size of each process is 1/8th root of n
    spawnBulkProcesses(trunc(:math.pow(n,1/8)),n,k, pid,1)

    # Fetch values appended in list by calling Genserver.call function
    IO.inspect(GenServer.call(pid,:result),limit: :infinity)
  end


  # Spawning Float.ceil(n/no) number of processes each with batch size = no(1/8th root of n)
  def spawnBulkProcesses(no,n,k,pid,i) do
    tasks =
      for x <- i..trunc(Float.ceil(n/no)) do

        Task.async(fn ->
          bulkCalculate((x*no)-no+1, checkValue(x*no,n) ,k,pid)
          x
    end)
  end

  # To await for each spawned tasks
  Enum.map(tasks, &Task.await/1)
  end

  def checkValue(xno, n) do
    if(xno > n) do
      n
    else
      xno
    end
  end


  # Calling calculateSum for values from start to n with interval of k
  def bulkCalculate(start,n,k, pid) do
    Enum.map(start..n, fn(x)-> calculateSum(x,x+k-1,pid) end)
  end


  # Adding squares of each number beginning from 'start' and ending at 'last'
  # Appending only perfect square root to list by calling Genserver.cast
  def calculateSum(start, last, pid) do
    sum = Enum.sum(Enum.map(start..last, fn(x)->x*x end))
    sqrt = :math.sqrt(sum)
    if( sqrt == trunc(sqrt)) do
      GenServer.cast(pid,{:result, start})
    end
  end
end
