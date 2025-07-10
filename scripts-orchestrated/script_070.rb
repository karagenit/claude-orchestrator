def factorial_memo(n, memo = {})
  return 1 if n <= 1
  
  memo[n] ||= n * factorial_memo(n - 1, memo)
end

class FactorialMemoizer
  def initialize
    @memo = { 0 => 1, 1 => 1 }
  end
  
  def factorial(n)
    return nil if n < 0
    
    @memo[n] ||= n * factorial(n - 1)
  end
  
  def reset_memo
    @memo = { 0 => 1, 1 => 1 }
  end
  
  def memo_size
    @memo.size
  end
  
  def precompute_up_to(n)
    (2..n).each { |i| factorial(i) }
  end
end

def factorial_iterative(n)
  return nil if n < 0
  return 1 if n <= 1
  
  result = 1
  (2..n).each { |i| result *= i }
  result
end

def factorial_tail_recursive(n, accumulator = 1)
  return nil if n < 0
  return accumulator if n <= 1
  
  factorial_tail_recursive(n - 1, n * accumulator)
end

def double_factorial(n)
  return nil if n < 0
  return 1 if n <= 1
  
  result = 1
  i = n
  while i > 0
    result *= i
    i -= 2
  end
  result
end

def subfactorial(n)
  return 1 if n == 0
  return 0 if n == 1
  
  result = 0
  (0..n).each do |k|
    result += ((-1) ** k) * factorial_iterative(n) / factorial_iterative(k)
  end
  result
end

def falling_factorial(n, k)
  return 1 if k == 0
  return nil if k > n || n < 0 || k < 0
  
  result = 1
  (n - k + 1..n).each { |i| result *= i }
  result
end

def rising_factorial(n, k)
  return 1 if k == 0
  return nil if k < 0
  
  result = 1
  (n..n + k - 1).each { |i| result *= i }
  result
end

def factorial_digit_sum(n)
  factorial_iterative(n).to_s.chars.map(&:to_i).sum
end

def factorial_trailing_zeros(n)
  return 0 if n < 5
  
  count = 0
  power_of_5 = 5
  
  while power_of_5 <= n
    count += n / power_of_5
    power_of_5 *= 5
  end
  
  count
end

def stirling_approximation(n)
  return 1 if n <= 1
  
  Math.sqrt(2 * Math::PI * n) * ((n / Math::E) ** n)
end

def factorial_prime_factorization(n)
  return {} if n <= 1
  
  factors = {}
  
  (2..n).each do |i|
    temp = i
    divisor = 2
    
    while divisor * divisor <= temp
      while temp % divisor == 0
        factors[divisor] = (factors[divisor] || 0) + 1
        temp /= divisor
      end
      divisor += 1
    end
    
    if temp > 1
      factors[temp] = (factors[temp] || 0) + 1
    end
  end
  
  factors
end

def factorial_mod(n, mod)
  return 1 if n <= 1
  
  result = 1
  (2..n).each do |i|
    result = (result * i) % mod
  end
  result
end

def wilson_theorem_check(p)
  return false if p <= 1
  
  factorial_mod(p - 1, p) == p - 1
end

def binomial_coefficient_factorial(n, k)
  return 0 if k > n || k < 0
  return 1 if k == 0 || k == n
  
  factorial_memo(n) / (factorial_memo(k) * factorial_memo(n - k))
end

def gamma_function_factorial(n)
  return nil if n < 0
  
  factorial_iterative(n - 1) if n > 0
end

if __FILE__ == $0
  puts "Factorial using memoization:"
  (0..10).each do |i|
    puts "#{i}! = #{factorial_memo(i)}"
  end
  
  puts "\nFactorial using iteration:"
  puts "20! = #{factorial_iterative(20)}"
  
  puts "\nDouble factorial:"
  puts "8!! = #{double_factorial(8)}"
  puts "9!! = #{double_factorial(9)}"
  
  puts "\nFactorial digit sum:"
  puts "Sum of digits in 10! = #{factorial_digit_sum(10)}"
  
  puts "\nTrailing zeros in factorial:"
  puts "Trailing zeros in 100! = #{factorial_trailing_zeros(100)}"
  
  puts "\nStirling approximation:"
  puts "10! ≈ #{stirling_approximation(10).round(2)}"
  puts "Actual 10! = #{factorial_iterative(10)}"
end