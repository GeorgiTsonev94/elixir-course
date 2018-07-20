defmodule TaskOne do
  def sum_list_elems([]), do: 0
  def sum_list_elems([head | tail]) do
    head + sum_list_elems(tail)
  end
end

defmodule TaskTwo do
  def length_list_elems([], size), do: size
  def length_list_elems([head | tail]), do: length_list_elems(tail, 1)
  def length_list_elems([head | tail], br) do
    br = br + 1
    length_list_elems(tail, br)
  end
end

defmodule TaskThree do
  def sum_list_even_elems([], sum), do: sum
  def sum_list_even_elems([head | tail]), do: sum_list_even_elems([head | tail], 0)
  def sum_list_even_elems([head | tail], temp) do
    if rem(head, 2) == 0 do
      temp = temp + head
      sum_list_even_elems(tail,temp)
    else
      sum_list_even_elems(tail,temp)
    end
  end
end

defmodule TaskFour do
  def lower_to_upper([], result), do: result
  def lower_to_upper([head | tail]), do: lower_to_upper([head | tail], [])
  def lower_to_upper([head | tail], list) do
    if String.starts_with?(head, "a") do
      list = list ++ [String.upcase(head)]
      lower_to_upper(tail,list)
    else
      lower_to_upper(tail,list)
    end
  end
end

    
    
  
