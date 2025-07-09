def fibonacci(n)
  return 0 if n == 0
  return 1 if n == 1
  
  prev_prev = 0
  prev = 1
  
  (2..n).each do |i|
    current = prev + prev_prev
    prev_prev = prev
    prev = current
  end
  
  prev
end