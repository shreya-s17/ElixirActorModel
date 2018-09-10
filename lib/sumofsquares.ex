defmodule SUMOFSQUARES do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__ ,[])
  end

  #---------------------- Callbacks ----------------------#

  def handle_cast({:result,value},state) do
    {:noreply, [value | state]}
  end
  def handle_call(:result,_from,state) do
    {:reply,state,state}
  end
  def init(args) do
    {:ok, args}
  end
  #------------------------ Client - side -----------------#

  def main(n,k) do
    {:ok,pid}=SUMOFSQUARES.start_link
    spawnBulkProcesses(trunc(:math.pow(n,1/8)),n,k, pid,1)
    IO.inspect(GenServer.call(pid,:result),limit: :infinity)
  end

  def spawnBulkProcesses(no,n,k,pid,i) do
    tasks =
      for x <- i..trunc(Float.ceil(n/no)) do
        Task.async(fn ->
          bulkCalculate((x*no)-no+1, checkValue(x*no,n) ,k,pid)
          x
    end)
  end
  Enum.map(tasks, &Task.await/1)
  end

  def checkValue(xno, n) do
    if(xno > n) do
      n
    else
      xno
    end
  end
  def bulkCalculate(start,n,k, pid) do
    Enum.map(start..n, fn(x)-> calculateSum(x,x+k-1,pid) end)
  end

  def calculateSum(start, last, pid) do
    sum = Enum.sum(Enum.map(start..last, fn(x)->x*x end))
    sqrt = :math.sqrt(sum)
    if( sqrt == trunc(sqrt)) do
      GenServer.cast(pid,{:result, start})
    end
  end
end
