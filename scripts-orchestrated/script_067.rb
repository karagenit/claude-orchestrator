def lcm(a, b)
  return 0 if a == 0 || b == 0
  
  (a.abs * b.abs) / gcd(a, b)
end

def gcd(a, b)
  while b != 0
    a, b = b, a % b
  end
  a.abs
end

def lcm_array(numbers)
  return 0 if numbers.empty? || numbers.any?(&:zero?)
  
  numbers.reduce { |acc, num| lcm(acc, num) }
end

def lcm_extended_euclidean(a, b)
  return 0 if a == 0 || b == 0
  
  gcd_val, _, _ = extended_gcd(a, b)
  (a.abs * b.abs) / gcd_val
end

def extended_gcd(a, b)
  return [a, 1, 0] if b == 0
  
  gcd_val, x1, y1 = extended_gcd(b, a % b)
  x = y1
  y = x1 - (a / b) * y1
  
  [gcd_val, x, y]
end

def lcm_multiple(*numbers)
  return 0 if numbers.empty? || numbers.any?(&:zero?)
  
  numbers.reduce { |acc, num| lcm(acc, num) }
end

def lcm_fraction(num1, den1, num2, den2)
  return [0, 1] if num1 == 0 || num2 == 0
  
  lcm_num = lcm(num1, num2)
  gcd_den = gcd(den1, den2)
  
  [lcm_num, gcd_den]
end

def lcm_prime_factorization(a, b)
  return 0 if a == 0 || b == 0
  
  factors_a = prime_factors_with_powers(a.abs)
  factors_b = prime_factors_with_powers(b.abs)
  
  all_primes = (factors_a.keys + factors_b.keys).uniq
  
  lcm_value = 1
  all_primes.each do |prime|
    max_power = [factors_a[prime] || 0, factors_b[prime] || 0].max
    lcm_value *= prime ** max_power
  end
  
  lcm_value
end

def prime_factors_with_powers(n)
  return {} if n <= 1
  
  factors = {}
  divisor = 2
  
  while divisor * divisor <= n
    while n % divisor == 0
      factors[divisor] = (factors[divisor] || 0) + 1
      n /= divisor
    end
    divisor += 1
  end
  
  factors[n] = 1 if n > 1
  factors
end

def lcm_using_binary_gcd(a, b)
  return 0 if a == 0 || b == 0
  
  (a.abs * b.abs) / binary_gcd(a, b)
end

def binary_gcd(a, b)
  a, b = a.abs, b.abs
  return b if a == 0
  return a if b == 0
  
  shift = 0
  while ((a | b) & 1) == 0
    a >>= 1
    b >>= 1
    shift += 1
  end
  
  while (a & 1) == 0
    a >>= 1
  end
  
  while b != 0
    while (b & 1) == 0
      b >>= 1
    end
    
    if a > b
      a, b = b, a
    end
    
    b -= a
  end
  
  a << shift
end

def lcm_range(start, finish)
  return 0 if start > finish
  
  (start..finish).reduce { |acc, num| lcm(acc, num) }
end

if __FILE__ == $0
  puts "LCM of 12 and 18: #{lcm(12, 18)}"
  puts "LCM of 15 and 25: #{lcm(15, 25)}"
  puts "LCM of array [4, 6, 8]: #{lcm_array([4, 6, 8])}"
  puts "LCM of multiple numbers (12, 15, 20): #{lcm_multiple(12, 15, 20)}"
  puts "LCM using prime factorization (12, 18): #{lcm_prime_factorization(12, 18)}"
  puts "LCM of range 1-5: #{lcm_range(1, 5)}"
end