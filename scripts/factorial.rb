def factorial(n)
  return 1 if n <= 1
  
  result = 1
  (2..n).each do |i|
    result *= i
  end
  
  result
end