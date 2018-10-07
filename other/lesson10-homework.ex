defmodule Homework do

  def my_task(list, char) do
    Enum.join(list, char)
  end

  #def my_task_rec([], _char, string), do: string
  def my_task_rec(list, char) do
    my_task_rec(list, char, "")
  end
  def my_task_rec([head | []], _char, string) do
    string <> to_string(head)
  end
  def my_task_rec([head | tail], char, string) do                
    my_task_rec(tail, char, (string <> to_string(head) <> char))
  end
        
end
