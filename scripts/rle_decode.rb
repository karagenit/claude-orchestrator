def rle_decode(str)
  return "" if str.nil? || str.empty?
  
  result = ""
  i = 0
  
  while i < str.length
    count = ""
    
    while i < str.length && str[i].match(/\d/)
      count += str[i]
      i += 1
    end
    
    if i < str.length
      char = str[i]
      result += char * count.to_i
      i += 1
    end
  end
  
  result
end