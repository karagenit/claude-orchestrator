def random_string(length, chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')
  return "" if length <= 0
  
  result = ""
  length.times do
    result += chars[rand(chars.length)]
  end
  
  result
end