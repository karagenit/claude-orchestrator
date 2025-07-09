def random_password(length = 12, include_symbols = true)
  return "" if length <= 0
  
  lowercase = 'abcdefghijklmnopqrstuvwxyz'
  uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  numbers = '0123456789'
  symbols = '!@#$%^&*()_+-=[]{}|;:,.<>?'
  
  chars = lowercase + uppercase + numbers
  chars += symbols if include_symbols
  
  password = ""
  length.times do
    password += chars[rand(chars.length)]
  end
  
  password
end