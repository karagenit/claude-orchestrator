def prime_factorization(n)
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