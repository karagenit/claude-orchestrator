def checksum(str)
  return 0 if str.nil? || str.empty?
  
  sum = 0
  str.each_byte { |byte| sum += byte }
  
  sum % 256
end