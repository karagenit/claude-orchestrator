def lcm(a, b)
  return 0 if a == 0 || b == 0
  
  (a.abs * b.abs) / gcd(a, b)
end

def gcd(a, b)
  while b != 0
    temp = b
    b = a % b
    a = temp
  end
  
  a.abs
end