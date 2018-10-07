defmodule Calculator do
  use GenServer
  
  def init(init_state) do
    {:ok, init_state}
  end
  
  def add_number(pid, number) do
    GenServer.call(pid, {:add, number})
  end
  
  def subs_number(pid, number) do
    GenServer.call(pid, {:subs, number})
  end
  
  def multi_number(pid, number) do
    GenServer.call(pid, {:multi, number})
  end
  
  def div_number(pid, number) do
    GenServer.call(pid, {:div, number})
  end
  
  def handle_call({:add, number}, _from, state) do                                                                                                 
  new_number =  number + state                                                                                                                    
    {:reply, new_number, new_number}
  end
  
  def handle_call({:subs, number}, _from, state) do
    new_number = state - number
     {:reply, new_number, new_number}
  end
  
  def handle_call({:multi, number}, _from, state) do
    new_number = number * state
    {:reply, new_number, new_number}
  end
  
  def handle_call({:div, number}, _from, state) do
    new_number = (state / number)
    {:reply, new_number, new_number}
  end
  

  def handle_call({:transform, function}, _from, state) do
    {:reply, function.(state), function.(state)}
  end

  def handle_call({:print, function}, _from, state) do
    {:reply, function.(state), state}
  end


  def handle_call(:state, _from, state) do
    {:reply, state, state}                                                                                                 
  end
  
  def handle_cast({:add, number}, state) do                                                                                                       
  new_state = number + state                                                                                                                     
    {:noreply, new_state}                                                                                                                          
  end  
end 
