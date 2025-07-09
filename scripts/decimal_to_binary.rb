def decimal_to_binary(decimal)
  return "0" if decimal == 0
  return "" if decimal < 0
  
  result = ""
  
  while decimal > 0
    result = (decimal % 2).to_s + result
    decimal /= 2
  end
  
  result
end