def gcd(a, b)
  while b != 0
    temp = b
    b = a % b
    a = temp
  end
  
  a.abs
end