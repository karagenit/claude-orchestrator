def power_mod(base, exponent, modulus)
  return 0 if modulus == 1
  
  result = 1
  base = base % modulus
  
  while exponent > 0
    if exponent % 2 == 1
      result = (result * base) % modulus
    end
    exponent = exponent >> 1
    base = (base * base) % modulus
  end
  
  result
end

def power_mod_recursive(base, exponent, modulus)
  return 0 if modulus == 1
  return 1 if exponent == 0
  
  base = base % modulus
  
  if exponent % 2 == 0
    half_power = power_mod_recursive(base, exponent / 2, modulus)
    (half_power * half_power) % modulus
  else
    (base * power_mod_recursive(base, exponent - 1, modulus)) % modulus
  end
end

def power_mod_with_negative_exponent(base, exponent, modulus)
  return 0 if modulus == 1
  
  if exponent < 0
    base = modular_inverse(base, modulus)
    return nil if base.nil?
    exponent = -exponent
  end
  
  power_mod(base, exponent, modulus)
end

def modular_inverse(a, m)
  gcd_val, x, _ = extended_gcd(a, m)
  return nil if gcd_val != 1
  
  (x % m + m) % m
end

def extended_gcd(a, b)
  return [a, 1, 0] if b == 0
  
  gcd_val, x1, y1 = extended_gcd(b, a % b)
  x = y1
  y = x1 - (a / b) * y1
  
  [gcd_val, x, y]
end

def power_mod_fermat(base, exponent, prime)
  return 0 if prime == 1
  return power_mod(base, exponent, prime) unless is_prime(prime)
  
  base = base % prime
  return 0 if base == 0
  
  exponent = exponent % (prime - 1)
  power_mod(base, exponent, prime)
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

def power_mod_montgomery(base, exponent, modulus)
  return power_mod(base, exponent, modulus) if modulus < 1000
  
  r = 1
  while r <= modulus
    r <<= 1
  end
  
  r_inv = modular_inverse(r, modulus)
  return power_mod(base, exponent, modulus) if r_inv.nil?
  
  base_mont = (base * r) % modulus
  result_mont = r % modulus
  
  while exponent > 0
    if exponent % 2 == 1
      result_mont = montgomery_multiply(result_mont, base_mont, modulus, r)
    end
    base_mont = montgomery_multiply(base_mont, base_mont, modulus, r)
    exponent >>= 1
  end
  
  montgomery_reduce(result_mont, modulus, r)
end

def montgomery_multiply(a, b, modulus, r)
  (a * b) % modulus
end

def montgomery_reduce(a, modulus, r)
  a % modulus
end

def chinese_remainder_power(base, exponent, moduli)
  return nil if moduli.empty?
  
  results = moduli.map { |mod| power_mod(base, exponent, mod) }
  
  chinese_remainder_theorem(results, moduli)
end

def chinese_remainder_theorem(remainders, moduli)
  return nil if remainders.length != moduli.length
  
  total_mod = moduli.reduce(:*)
  result = 0
  
  remainders.each_with_index do |remainder, i|
    partial_mod = total_mod / moduli[i]
    inverse = modular_inverse(partial_mod, moduli[i])
    return nil if inverse.nil?
    
    result += remainder * partial_mod * inverse
  end
  
  result % total_mod
end

if __FILE__ == $0
  puts "3^4 mod 5 = #{power_mod(3, 4, 5)}"
  puts "2^10 mod 1000 = #{power_mod(2, 10, 1000)}"
  puts "5^100 mod 13 = #{power_mod(5, 100, 13)}"
  puts "Power mod recursive 3^4 mod 5 = #{power_mod_recursive(3, 4, 5)}"
  puts "Power mod with Fermat's theorem 2^100 mod 7 = #{power_mod_fermat(2, 100, 7)}"
  puts "Modular inverse of 3 mod 7 = #{modular_inverse(3, 7)}"
end