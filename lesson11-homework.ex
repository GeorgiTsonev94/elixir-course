defmodule Homework do

  def taskOne do
    receive do
      :foo -> IO.puts("Done the first task")
      _ -> IO.puts("Done the second task")
    end
  taskOne()
  end
  
    
      

end
