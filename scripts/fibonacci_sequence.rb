def fibonacci_sequence(n)
  return [] if n <= 0
  return [0] if n == 1
  
  sequence = [0, 1]
  
  (2...n).each do |i|
    sequence << sequence[i - 1] + sequence[i - 2]
  end
  
  sequence
end