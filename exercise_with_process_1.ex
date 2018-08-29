defmodule Ex do

  def taskOne do
    spawn fn -> IO.puts("Hello, world") end
  end
    
  def taskTwo(pid, num) do
   spawn fn -> send(pid, {:num, num*2}) end
    receive do
      {:num, result} -> result
    end
  end
  
  def taskThree(pid, func) do
    spawn fn -> send(pid, {:result, func}) end
    receive do
      {:result, result} -> result.()
    end
  end
  
  def taskFour(list), do: taskFour(list, [])
  def taskFour([], newList), do: Enum.reverse(newList)
  def taskFour(list, newList), do: taskFour(list, newList, self(), length(list))
  def taskFour([h | t], newList, pid, lengthList) do
    spawn fn -> send(pid, {:num, h*2}) end
    taskFour(t, newList, pid, lengthList)
  end
  def taskFour([], newList, pid, lengthList) do
    if lengthList > 0 do
      elem = receive do
        {:num, num} -> num
      end
      taskFour([], [elem | newList], pid, lengthList - 1)
    else
      taskFour([], newList)
      # taskFour([], Enum.reverse(Enum.sort(newList)))
    end
  end
end

