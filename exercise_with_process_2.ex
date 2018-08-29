defmodule Ex do

  def taskOne do
    spawn fn ->
      receive do
        {:ping} -> IO.puts("Ping")
      end
      taskOne()
    end
  end

  def ping() do
    spawn fn ->
      receive do
        {:ping, send_to} ->
          Process.sleep(1000)
          IO.puts("Ping")
          send(send_to, {:pong, ping()})
          {:kill} -> System.halt
      end
    end
  end
  
 
   def pong do
     spawn fn ->
       receive do
         {:pong, send_to} ->
           Process.sleep(1000)
           IO.puts("Pong")
           send(send_to, {:ping, pong()})
       end
     end
   end  
end
