defmodule TodoApp do
  @moduledoc """
  Documentation for TodoApp.
  """

  def new(), do: []

  def add(todo_list, id, text, date, complete) do
    [%{id: id,description: text,date: date,complete: complete} | todo_list]
  end

  def find(todo_list, id) do
    Enum.filter(todo_list, fn x -> x.id == id end)
  end

  def remove(todo_list, id) do
    Enum.filter(todo_list, fn x -> x.id != id end)
  end  
end
