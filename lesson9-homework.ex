defmodule Homework do

  def all_true(list, check) when is_list(list) and is_function(check) do
   if Enum.find(list, fn x -> check.(x) == false end) do
     "false"
   else
     "true"
    end
  end
  def all_true(list, check), do: "We need a list and function!"

  
  def any_true(list, check) when is_list(list) and is_function(check) do
    if Enum.find(list, fn x -> check.(x) == true end) do
      "true"
    else
      "false"
     end
  end
  def any_true(list, check), do: "We need a list and function!"

  
  def get_element_at(list, item, value)
    when is_list(list) and is_integer(item) and is_integer(value) do
    if length(list) > item  do
      Enum.at(list, item)
    else
      value
    end
  end
  def get_element_at(list, item, value), do: "We need three integers!"

  
  def max_by(list, check) when is_list(list) and is_function(check) do
    Enum.max_by(list, fn x-> check.(x) end)
  end
  def max_by(list, check), do: "We need list and function!"


  def take_first_n(list, value) when is_list(list) and is_integer(value) do
    Enum.take(list, value)
  end
  def take_first_n(list, value), do: "We need list and integer!"
end
