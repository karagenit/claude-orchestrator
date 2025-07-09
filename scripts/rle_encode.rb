def rle_encode(str)
  return "" if str.nil? || str.empty?
  
  result = ""
  i = 0
  
  while i < str.length
    current_char = str[i]
    count = 1
    
    while i + count < str.length && str[i + count] == current_char
      count += 1
    end
    
    result += "#{count}#{current_char}"
    i += count
  end
  
  result
end