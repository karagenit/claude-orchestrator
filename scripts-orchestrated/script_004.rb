def fibonacci(n)
  raise ArgumentError, "Fibonacci is not defined for negative numbers" if n < 0
  
  return n if n <= 1
  
  a, b = 0, 1
  (2..n).each do
    a, b = b, a + b
  end
  
  b
end

def fibonacci_recursive(n)
  raise ArgumentError, "Fibonacci is not defined for negative numbers" if n < 0
  
  return n if n <= 1
  
  fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2)
end

def fibonacci_memoized(n, memo = {})
  raise ArgumentError, "Fibonacci is not defined for negative numbers" if n < 0
  
  return n if n <= 1
  return memo[n] if memo.key?(n)
  
  memo[n] = fibonacci_memoized(n - 1, memo) + fibonacci_memoized(n - 2, memo)
end

def fibonacci_sequence(n)
  raise ArgumentError, "Fibonacci sequence length must be non-negative" if n < 0
  
  return [] if n == 0
  return [0] if n == 1
  
  sequence = [0, 1]
  (2...n).each do |i|
    sequence[i] = sequence[i - 1] + sequence[i - 2]
  end
  
  sequence
end

def fibonacci_matrix(n)
  raise ArgumentError, "Fibonacci is not defined for negative numbers" if n < 0
  
  return n if n <= 1
  
  base_matrix = [[1, 1], [1, 0]]
  result_matrix = matrix_power(base_matrix, n - 1)
  
  result_matrix[0][0]
end

def matrix_multiply(a, b)
  result = Array.new(2) { Array.new(2, 0) }
  
  2.times do |i|
    2.times do |j|
      2.times do |k|
        result[i][j] += a[i][k] * b[k][j]
      end
    end
  end
  
  result
end

def matrix_power(matrix, n)
  return [[1, 0], [0, 1]] if n == 0
  return matrix if n == 1
  
  if n.even?
    half = matrix_power(matrix, n / 2)
    matrix_multiply(half, half)
  else
    matrix_multiply(matrix, matrix_power(matrix, n - 1))
  end
end

if __FILE__ == $0
  puts "Fibonacci calculations:"
  (0..15).each do |i|
    puts "F(#{i}) = #{fibonacci(i)}"
  end
  
  puts "\nFibonacci using different methods:"
  puts "Iterative F(10): #{fibonacci(10)}"
  puts "Recursive F(10): #{fibonacci_recursive(10)}"
  puts "Memoized F(10): #{fibonacci_memoized(10)}"
  puts "Matrix F(10): #{fibonacci_matrix(10)}"
  puts "Sequence F(0..10): #{fibonacci_sequence(11)}"
end