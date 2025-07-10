def prime_factors(n)
  return [] if n <= 1
  
  factors = []
  divisor = 2
  
  while divisor * divisor <= n
    while n % divisor == 0
      factors << divisor
      n /= divisor
    end
    divisor += 1
  end
  
  factors << n if n > 1
  factors
end

def prime_factors_optimized(n)
  return [] if n <= 1
  
  factors = []
  
  while n % 2 == 0
    factors << 2
    n /= 2
  end
  
  divisor = 3
  while divisor * divisor <= n
    while n % divisor == 0
      factors << divisor
      n /= divisor
    end
    divisor += 2
  end
  
  factors << n if n > 1
  factors
end

def unique_prime_factors(n)
  prime_factors(n).uniq
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

def is_prime(n)
  return false if n <= 1
  return true if n == 2
  return false if n % 2 == 0
  
  (3..Math.sqrt(n)).step(2) do |i|
    return false if n % i == 0
  end
  
  true
end

def largest_prime_factor(n)
  factors = prime_factors(n)
  factors.empty? ? nil : factors.max
end

def smallest_prime_factor(n)
  factors = prime_factors(n)
  factors.empty? ? nil : factors.min
end

def count_prime_factors(n)
  prime_factors(n).length
end

def product_of_prime_factors(n)
  factors = unique_prime_factors(n)
  factors.reduce(1, :*)
end

def is_semiprime(n)
  factors = prime_factors(n)
  factors.length == 2
end

def prime_factorization_string(n)
  factors_hash = prime_factors_with_powers(n)
  return "1" if factors_hash.empty?
  
  factors_hash.map do |prime, power|
    power == 1 ? prime.to_s : "#{prime}^#{power}"
  end.join(" * ")
end

def pollard_rho_factor(n)
  return n if is_prime(n)
  
  x = 2
  y = 2
  d = 1
  
  f = lambda { |x| (x * x + 1) % n }
  
  while d == 1
    x = f.call(x)
    y = f.call(f.call(y))
    d = gcd((x - y).abs, n)
  end
  
  d == n ? nil : d
end

def gcd(a, b)
  while b != 0
    a, b = b, a % b
  end
  a
end

if __FILE__ == $0
  test_numbers = [60, 97, 100, 17, 1001]
  
  test_numbers.each do |num|
    puts "Number: #{num}"
    puts "Prime factors: #{prime_factors(num)}"
    puts "Unique prime factors: #{unique_prime_factors(num)}"
    puts "Prime factors with powers: #{prime_factors_with_powers(num)}"
    puts "Factorization: #{prime_factorization_string(num)}"
    puts "Is prime: #{is_prime(num)}"
    puts "Largest prime factor: #{largest_prime_factor(num)}"
    puts "---"
  end
end