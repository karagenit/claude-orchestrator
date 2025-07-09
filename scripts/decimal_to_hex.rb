def decimal_to_hex(decimal)
  return "0" if decimal == 0
  return "" if decimal < 0
  
  hex_chars = "0123456789ABCDEF"
  result = ""
  
  while decimal > 0
    result = hex_chars[decimal % 16] + result
    decimal /= 16
  end
  
  result
end