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
   IO.puts(" #{inspect :erlang.statistics(:runtime)}")
    IO.inspect(GenServer.call(pid,:result),limit: :infinity)
  end
 
  def spawnBulkProcesses(no,n,k,pid,i) do 
    if(i <= n) do
      spawn(fn -> send self(), bulkCalculate(i, checkValue(i,no,n),k,pid) end) 
      spawnBulkProcesses(no,n,k,pid,i+no)
    end
  end 
 
  def checkValue(i,no,n) do
    if(i+no>n) do 
      n
    else 
      i+no-1 
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