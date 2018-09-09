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
   spawnTwoMachines()
  #Node.spawn_link :"foo@192.168.0.6" , fn -> trunc(:math.pow(n,1/8)),n,k, pid,1) end
  spawnBulkProcesses(trunc(:math.pow(n,1/8)),n,k, pid,1)
  IO.puts("#{ inspect :erlang.statistics(:runtime)} #{inspect :erlang.statistics(:wall_clock)}")
  IO.inspect(GenServer.call(pid,:result),limit: :infinity)
  end
 
  def spawnBulkProcesses(no,n,k,pid,i) do
    if(i <= n) do
     # Node.spawn_link , fn-> bulkCalculate(i, checkValue(i,no,n),k,pid) end
      IO.puts("in here")
    spawnBulkProcesses(no,n,k,pid,i+no)
    end
  end 
 
  def spawnTwoMachines() do
    {:ok, ip} = :inet.getif()
    x=  hd(ip) |> elem(0) |> Tuple.to_list |> Enum.join(".")
    firstIP = String.to_atom("xyz@" <> x)
    Node.start firstIP
    Node.set_cookie :sss
    IO.puts("#{inspect Node.connect :"foo@192.168.0.6"}")
    IO.puts("#{inspect Node.list}")
    ip = String.to_atom("boo@192.168.0.6")
    abc = Node.spawn_link :"boo@192.168.0.6", &Hello1.world/0
    IO.puts("#{inspect abc}")
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
 
 