def generate_primes(limit)
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
  is_prime.each_with_index do |prime, num|
    primes << num if prime
  end
  
  primes
end