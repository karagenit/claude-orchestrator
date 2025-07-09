def hash_string(str)
  return 0 if str.nil? || str.empty?
  
  hash = 0
  str.each_byte do |byte|
    hash = ((hash << 5) - hash) + byte
    hash = hash & 0xffffffff
  end
  
  hash
end