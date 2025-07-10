def prime_check(n)
  return false if n < 2
  return true if n == 2
  return false if n.even?
  
  (3..Math.sqrt(n)).step(2) do |i|
    return false if n % i == 0
  end
  
  true
end

def prime_check_basic(n)
  return false if n < 2
  
  (2...n).each do |i|
    return false if n % i == 0
  end
  
  true
end

def prime_check_optimized(n)
  return false if n < 2
  return true if n == 2 || n == 3
  return false if n % 2 == 0 || n % 3 == 0
  
  i = 5
  while i * i <= n
    return false if n % i == 0 || n % (i + 2) == 0
    i += 6
  end
  
  true
end

def sieve_of_eratosthenes(limit)
  return [] if limit < 2
  
  is_prime = Array.new(limit + 1, true)
  is_prime[0] = is_prime[1] = false
  
  (2..Math.sqrt(limit)).each do |i|
    if is_prime[i]
      (i * i..limit).step(i) do |j|
        is_prime[j] = false
      end
    end
  end
  
  primes = []
  is_prime.each_with_index do |prime, index|
    primes << index if prime
  end
  
  primes
end

def next_prime(n)
  n += 1
  n += 1 until prime_check(n)
  n
end

def prime_factors(n)
  return [] if n < 2
  
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

if __FILE__ == $0
  puts "Prime checking methods:"
  test_numbers = [2, 3, 4, 5, 17, 25, 29, 97, 100, 101]
  
  test_numbers.each do |num|
    puts "#{num}: #{prime_check(num)}"
  end
  
  puts "\nPrime numbers up to 30:"
  primes = sieve_of_eratosthenes(30)
  puts primes.inspect
  
  puts "\nNext prime after 20: #{next_prime(20)}"
  puts "Prime factors of 60: #{prime_factors(60)}"
  puts "Prime factors of 97: #{prime_factors(97)}"
end