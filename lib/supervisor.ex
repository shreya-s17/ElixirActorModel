defmodule Basic do
    use GenServer

    def start_link do
        GenServer.start_link(__MODULE__,[])
    end

    def init(initial_data) do
        {:ok, initial_data}
    end
end
