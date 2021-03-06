defmodule CalculatorSup do
  use GenServer
  alias CalculatorSupp

  def start_link(_args) do
    GenServer.start_link(__MODULE__, CalculatorSupp.state, name: __MODULE__)
  end
    
  def init(state) do
    {:ok, state}
  end

  def add_number(number) do
    GenServer.call(__MODULE__, {:add, number})
  end

  def state, do: GenServer.call(__MODULE__, {:state})

  def handle_call({:add, number}, _from, state) do
    state = state + number
    CalculatorSupp.new_state(state)
    {:reply, state, state}
  end

  def handle_call({:state}, _from, state) do
    {:reply, state, state}
  end
end

defmodule CalculatorSupp do
  use GenServer

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, 0, name:  __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def state, do: GenServer.call(__MODULE__, {:state})
  
  def new_state(new_state), do: GenServer.cast(__MODULE__, {:new_state, new_state})
  
  def handle_call({:state}, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:new_state, new_state}, _state) do
    {:noreply, new_state}
  end
  
end

