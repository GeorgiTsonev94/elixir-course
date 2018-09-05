defmodule Refrigerator do

  def start do
    spawn fn -> handler(%{}) end
  end

  def handler(map) do
    receive do
      {:add, product, quantity} ->
        if Map.has_key?(map, product) do
          handler(Map.update!(map, product, fn x -> x + quantity end))
        else
          handler(Map.put(map, product, quantity))
        end
      {:status} ->
        IO.inspect(map)
        handler(map)
      {:take, product, quantity} ->
        if Map.has_key?(map, product) do
            if Map.get(map, product) > quantity do
              handler(Map.update!(map, product , fn x -> x - quantity end))
            else
              handler(Map.delete(map, product))
            end
        else
          IO.puts("There isn't such product in the refrigerator")
          handler(map)
        end  
    end
  end

  def add(pid, product, quantity) do
    send(pid, {:add, product, quantity})
  end

  def status(pid) do
    send(pid, {:status})
  end
  
  def take(pid, product, quantity) do
    send(pid, {:take, product, quantity})
  end
end
