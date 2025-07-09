def base64_encode(str)
  return "" if str.nil? || str.empty?
  
  chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  result = ""
  
  (0...str.length).step(3) do |i|
    group = str[i, 3]
    
    n = 0
    group.each_byte.with_index do |byte, j|
      n |= byte << (8 * (2 - j))
    end
    
    padding = 3 - group.length
    
    4.times do |j|
      if j < 4 - padding
        result += chars[(n >> (6 * (3 - j))) & 63]
      else
        result += '='
      end
    end
  end
  
  result
end