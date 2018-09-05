defmodule Refrigerator do
  use GenServer
  
  def init(map) do
    {:ok, map}
  end

  def add(pid, product, quantity) do
    GenServer.call(pid, {:add, product, quantity})
  end

  def status(pid) do
    GenServer.call(pid, {:status})
  end

  def take(pid, product, quantity) do
    GenServer.call(pid, {:take, product, quantity})
  end

  def handle_call({:add, product, quantity}, _from, map) do
    if Map.has_key?(map, product) do
      new_map =  Map.update!(map, product, fn x -> x + quantity end)
      {:reply, new_map, new_map}
    else
      new_map = Map.put(map, product, quantity)
      {:reply, new_map, new_map}
    end
  end

  def handle_call({:status}, _from, map) do
    {:reply, map, map}
  end

  def handle_call({:take, product, quantity}, _from, map) do
    if Map.has_key?(map, product) do
      if Map.get(map, product) > quantity do
        new_map = Map.update!(map, product, fn x -> x - quantity end)
        {:reply, new_map, new_map}
      else
        new_map = Map.delete(map, product)
        {:reply, new_map, new_map}
      end
    else
      IO.puts("There isn't such product in the refrigerator")
      {:reply, map, map}
    end
  end
end
