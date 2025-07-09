def power_of_two(n)
  return false if n <= 0
  
  (n & (n - 1)) == 0
end