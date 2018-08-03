defmodule Homework do

  def largestNumber(list) when is_list(list) do
    Enum.reduce(list, 0, fn x, acc ->
      if x > acc do acc = x
      else acc end end)
  end
  def largestNumber(list), do: "This is not a list!"


  def powerOfNumber(numb, pow)
  when is_integer(numb) and is_integer(pow) do
    powerOfNumber(numb, pow, numb) end
  def powerOfNumber(numb, pow), do: "We need two integer numbers"
  def powerOfNumber(numb, pow, result) do
    if pow > 1 do
      powerOfNumber(numb, pow - 1, result * numb)
    else
      result end 
  end


  def digitsCount(numb) when is_integer(numb) do
    digitsCount(to_string(numb), 0)
  end
  def digitsCount(numb), do: "This is not integer number!"
  def digitsCount(string, count) do
    if string != "" do
      digitsCount(String.slice(string,1..-1), count + 1)
    else
      count
    end
  end

  
  def biggestDenominator(a, b) when is_integer(a) and is_integer(b) do
    cond do
      a == 0 -> 0
      b == 0 -> 0
      a == b -> a
      a > b -> biggestDenominator(a-b, b)
      b > a -> biggestDenominator(a, b-a)
      false -> "The is not any common dominator!"
    end
  end
  
  
  def naturalNumbers(), do: naturalNumbers(1, 0)
  def naturalNumbers(numb, sum) do
    if numb < 1000 do
      if rem(numb,3)==0 || rem(numb,5)==0 do
        naturalNumbers(numb + 1, sum + numb)
      else
        naturalNumbers(numb + 1, sum) end
    else
      sum end
  end

  def fibonacci(), do: fibonacci(1, 2, 0)
  def fibonacci(a, b, sumEven) do
    if a < 4000000 || b < 4000000 do
      if rem(b, 2) == 0 do
        fibonacci(b, a + b, sumEven + b)
      else fibonacci(b, a + b, sumEven)
      end
    else
      sumEven
    end
  end  
end
