def factorial(n)
  raise ArgumentError, "Factorial is not defined for negative numbers" if n < 0
  
  return 1 if n == 0 || n == 1
  
  result = 1
  (2..n).each do |i|
    result *= i
  end
  
  result
end

def factorial_recursive(n)
  raise ArgumentError, "Factorial is not defined for negative numbers" if n < 0
  
  return 1 if n == 0 || n == 1
  
  n * factorial_recursive(n - 1)
end

def factorial_memoized(n, memo = {})
  raise ArgumentError, "Factorial is not defined for negative numbers" if n < 0
  
  return 1 if n == 0 || n == 1
  return memo[n] if memo.key?(n)
  
  memo[n] = n * factorial_memoized(n - 1, memo)
end

def factorial_array(n)
  raise ArgumentError, "Factorial is not defined for negative numbers" if n < 0
  
  return [1] if n == 0 || n == 1
  
  factorials = [1, 1]
  (2..n).each do |i|
    factorials[i] = factorials[i - 1] * i
  end
  
  factorials
end

if __FILE__ == $0
  puts "Factorial calculations:"
  (0..10).each do |i|
    puts "#{i}! = #{factorial(i)}"
  end
  
  puts "\nRecursive factorial of 5: #{factorial_recursive(5)}"
  puts "Memoized factorial of 5: #{factorial_memoized(5)}"
  puts "Factorial array up to 5: #{factorial_array(5)}"
end