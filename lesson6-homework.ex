defmodule Homework do

  def calculateList(list) when is_list(list) do
    Enum.reduce(list, 0, fn x, acc -> x + acc end)
  end
  def calculateList(list) when not is_list(list) do
    {:error, "This is not a list!"}
  end
  

  def concatinateList(list) when is_list(list) do
    Enum.reduce(list, "", fn x, acc -> x <> acc end)
  end
  def concatinateList(list) when not is_list(list) do
    {:error, "This is not a list!"}
  end
  

  def removeOddOnes(list) when is_list(list) do
    Enum.reduce(list, [], fn x, acc -> if rem(x, 2) == 0
        do [x | acc] else acc end end)
  end
  def removeOddOnes(list) when not is_list(list) do
    {:error, "This is not a list!"}
  end
  
    
  def checkList(list) when is_list(list) do
    if Enum.reduce(list, 0, fn x, acc -> if x do acc+1 end end) > 0 do
      {:ok, "true"}
    else
      {:ok, "false"}
    end
  end
  def checkList(list) when not is_list(list) do
    {:error, "This is not a list"}
  end


  def calculateEven(list) when is_list(list) do
    Enum.reduce(list, 0, fn x, acc -> if rem(x, 2) == 0
        do acc + x else acc end end)
  end
  def calculateEven(list) when not is_list(list) do
    {:error, "This is not a list!"}
  end



  
  def doubleListElems(list) when is_list(list) do
    Enum.reduce(list, [], fn x, acc -> [x*2 | acc] end)
  end
  def doubleListElems(list) when not is_list(list) do
    {:error , "This is not a list!"}
  end


  def doubleOnlyEvenElems(list) when is_list(list) do
    Enum.reduce(list, [], fn x, acc -> if rem(x, 2) == 0 do
      [x*2 | acc] else [x | acc] end end)
  end
  def doubleOnlyEvenElems(list) when not is_list(list) do
    {:error, "This is not a list!"}
  end
  
end


defmodule Refrigerator do

  def new() do
    %{}
  end

  def add(refrigerator, item, count) do
    if Map.has_key?(refrigerator, item) do
      Map.update!(refrigerator, item, fn x -> x + count end)
    else
      Map.put(refrigerator, item, count)
    end
  end

  def remove(refrigerator, item, count) do
    Map.update!(refrigerator, item, fn x -> if x - count > 0 do
                                                   x - count else
                                                     0 end end)
  end
end
