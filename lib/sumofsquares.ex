defmodule SUMOFSQUARES do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__ ,[])
  end

  #---------------------- Callbacks ----------------------#

  def handle_cast({:result,value},state) do
    #IO.puts("state is#{inspect state}")
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
    :erlang.statistics(:runtime)
    :erlang.statistics(:wall_clock)
    {:ok,pid}=SUMOFSQUARES.start_link
    
    #if(n>1000) do
      #spawnBulkProcesses(1000,n,k, pid,0)
    #else
      spawnBulkProcesses(1000,n,k, pid,1)
    
    IO.puts("#{ inspect :erlang.statistics(:runtime)} #{inspect :erlang.statistics(:wall_clock)}")
    IO.inspect(GenServer.call(pid,:result),limit: :infinity)
  end

  def spawnBulkProcesses(no,n,k,pid,i) do
  #IO.inspect(i)

    if(i <= n) do
      spawn(fn -> send self(), bulkCalculate(i, checkValue(i,no,n),k,pid) end) 
      #x=checkValue(i,no,n)
      #IO.puts("aaa #{inspect x}")           
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
    #if(start <= n) do
      #calculateSum(start,start+k-1,pid)
      #bulkCalculate(start+1,n,k,pid)
    #end
  end

  def calculateSum(start, last, pid) do
    sum = Enum.sum(Enum.map(start..last, fn(x)->x*x end))
    sqrt = :math.sqrt(sum)
    if( sqrt == trunc(sqrt)) do
    GenServer.cast(pid,{:result, start})
    end
  end
end
