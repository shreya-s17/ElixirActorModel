defmodule SUMOFSQUARES do
  use GenServer

#---------------------- Callbacks ----------------------

def handle_call({:get_the_greeting},_from,mystate) do
  IO.puts("Hey I am handling synchronous calls")
  current_greeting = Map.get(mystate, :greeting)
  {:reply, current_greeting,mystate}
end
def handle_call({:set_the_greeting, newgreet},_from,mystate) do
  IO.puts("Hey I am updating message in synchronous calls")
  newstate = Map.put(mystate,:greeting,newgreet)
  {:reply, newstate, newstate}
end
def init(initial_data) do
  greetings = %{:greeting => initial_data}
  IO.puts("hey this is init")
  {:ok, greetings}
end

#------------------------ Client - side -------------------

  def startProcess() do
    {:ok, basic_pid} = SUMOFSQUARES.start_link
    state = get_my_state(basic_pid)
    IO.puts("Hey this is client side state #{inspect state}")
    newg = set_the_greeting(basic_pid, "huhuhu")
    IO.puts("Hey I am the new message #{inspect newg}")
  end
  def get_my_state(process_id) do
    IO.puts("Hey I trying to get GenServer process")
    GenServer.call(process_id, {:get_the_greeting})
  end
  def set_the_greeting(process_id, new_greeting) do
    IO.puts("Hey I am trying to update GenServer process")
    GenServer.call(process_id, {:set_the_greeting, new_greeting})
  end

#/////////////////////// Server - side ////////////////////

  def start_link do
    GenServer.start_link(__MODULE__ ,"HELLO")
  end

#/////////////////////////////////
  def hello do
    :world
  end
  def calculateSum(start, last) do
    result = :math.sqrt(((last*(last+1)*(2*last+1))/6) - ((start*(start+1)*(2*start+1))/6));
    ##IO.puts("Calculatesum start #{inspect start} result #{inspect result}")
    if(result ==  trunc(result)) do
      IO.puts(" result #{inspect start} amrr #{inspect self()}")
      start+1
    else
      ##IO.puts(" result #{inspect yy}")
      false
    end
  end
# n= 3 k=2 start = 0  0 2 nil  1 3 nil   2 4 3 
  def sendValues(start,n,k) do
    ##IO.puts("yuhu")
    if(start< n) do
      spawn fn -> send self(), {:ans, calculateSum(start, k + start)} end
      sendValues(start+1,n,k)
    else
    ##IO.puts("Im going to collect")
      shreya =  (collect([],n)) |> Enum.reduce(&(&1 || &2)) 
       ##IO.puts("start #{inspect start}  n #{inspect n} start #{inspect start} #{inspect shreya}")   
    end
   
    #sendValues(n, span, start+1)
  end
  def collect(list,counter) do
    ##IO.puts("Im going to collect inside")
    if(counter ==0) do
    list
    else
        ##IO.puts("Im going to collect inside1 #{inspect counter}")
      receive do
      {:ans, value} -> value
      end
      ##IO.puts("list #{inspect list}")
    end
  end
end