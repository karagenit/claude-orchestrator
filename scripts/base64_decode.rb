def base64_decode(str)
  return "" if str.nil? || str.empty?
  
  chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  char_map = {}
  chars.each_char.with_index { |c, i| char_map[c] = i }
  
  result = ""
  str = str.gsub(/=+$/, '')
  
  (0...str.length).step(4) do |i|
    group = str[i, 4]
    
    n = 0
    group.each_char.with_index do |char, j|
      n |= char_map[char] << (6 * (3 - j))
    end
    
    (0...group.length - 1).each do |j|
      result += ((n >> (8 * (2 - j))) & 255).chr
    end
  end
  
  result
end