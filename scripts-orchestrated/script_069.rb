def fibonacci_memo(n, memo = {})
  return n if n <= 1
  
  memo[n] ||= fibonacci_memo(n - 1, memo) + fibonacci_memo(n - 2, memo)
end

class FibonacciMemoizer
  def initialize
    @memo = {}
  end
  
  def fibonacci(n)
    return n if n <= 1
    
    @memo[n] ||= fibonacci(n - 1) + fibonacci(n - 2)
  end
  
  def reset_memo
    @memo.clear
  end
  
  def memo_size
    @memo.size
  end
end

def fibonacci_iterative(n)
  return n if n <= 1
  
  a, b = 0, 1
  (2..n).each do
    a, b = b, a + b
  end
  
  b
end

def fibonacci_matrix(n)
  return n if n <= 1
  
  result = matrix_power([[1, 1], [1, 0]], n - 1)
  result[0][0]
end

def matrix_power(matrix, n)
  return [[1, 0], [0, 1]] if n == 0
  return matrix if n == 1
  
  if n % 2 == 0
    half = matrix_power(matrix, n / 2)
    matrix_multiply(half, half)
  else
    matrix_multiply(matrix, matrix_power(matrix, n - 1))
  end
end

def matrix_multiply(a, b)
  result = Array.new(2) { Array.new(2, 0) }
  
  (0...2).each do |i|
    (0...2).each do |j|
      (0...2).each do |k|
        result[i][j] += a[i][k] * b[k][j]
      end
    end
  end
  
  result
end

def fibonacci_sequence(n)
  return [] if n <= 0
  return [0] if n == 1
  
  sequence = [0, 1]
  (2...n).each do |i|
    sequence << sequence[i-1] + sequence[i-2]
  end
  
  sequence
end

def fibonacci_golden_ratio(n)
  return n if n <= 1
  
  phi = (1 + Math.sqrt(5)) / 2
  psi = (1 - Math.sqrt(5)) / 2
  
  ((phi ** n - psi ** n) / Math.sqrt(5)).round
end

def fibonacci_sum(n)
  return 0 if n <= 0
  
  fib_n_plus_2 = fibonacci_memo(n + 2)
  fib_n_plus_2 - 1
end

def fibonacci_even_sum(n)
  sum = 0
  a, b = 0, 1
  
  while a <= n
    sum += a if a % 2 == 0
    a, b = b, a + b
  end
  
  sum
end

def is_fibonacci(num)
  return true if num == 0 || num == 1
  
  a, b = 0, 1
  while b < num
    a, b = b, a + b
  end
  
  b == num
end

def fibonacci_index(num)
  return 0 if num == 0
  return 1 if num == 1
  
  a, b = 0, 1
  index = 1
  
  while b < num
    a, b = b, a + b
    index += 1
  end
  
  b == num ? index : nil
end

def fibonacci_modulo(n, mod)
  return n % mod if n <= 1
  
  a, b = 0, 1
  (2..n).each do
    a, b = b, (a + b) % mod
  end
  
  b
end

def pisano_period(m)
  return 0 if m <= 0
  
  prev, curr = 0, 1
  (0...m*m).each do |i|
    prev, curr = curr, (prev + curr) % m
    return i + 1 if prev == 0 && curr == 1
  end
  
  0
end

if __FILE__ == $0
  puts "Fibonacci numbers using memoization:"
  (0..10).each do |i|
    puts "F(#{i}) = #{fibonacci_memo(i)}"
  end
  
  puts "\nFibonacci sequence up to 10 terms:"
  puts fibonacci_sequence(10).inspect
  
  puts "\nFibonacci using matrix exponentiation:"
  puts "F(20) = #{fibonacci_matrix(20)}"
  
  puts "\nFibonacci using golden ratio:"
  puts "F(15) = #{fibonacci_golden_ratio(15)}"
  
  puts "\nSum of first 10 Fibonacci numbers: #{fibonacci_sum(10)}"
  puts "Is 21 a Fibonacci number? #{is_fibonacci(21)}"
end