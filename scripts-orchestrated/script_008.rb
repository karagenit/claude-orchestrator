def gcd(a, b)
  a, b = a.abs, b.abs
  
  while b != 0
    a, b = b, a % b
  end
  
  a
end

def gcd_recursive(a, b)
  a, b = a.abs, b.abs
  
  return a if b == 0
  
  gcd_recursive(b, a % b)
end

def gcd_extended(a, b)
  a, b = a.abs, b.abs
  
  return [a, 1, 0] if b == 0
  
  gcd_val, x1, y1 = gcd_extended(b, a % b)
  
  x = y1
  y = x1 - (a / b) * y1
  
  [gcd_val, x, y]
end

def lcm(a, b)
  return 0 if a == 0 || b == 0
  
  (a.abs * b.abs) / gcd(a, b)
end

def gcd_multiple(*numbers)
  return 0 if numbers.empty?
  return numbers.first.abs if numbers.length == 1
  
  result = numbers.first.abs
  numbers[1..-1].each do |num|
    result = gcd(result, num.abs)
    break if result == 1
  end
  
  result
end

def lcm_multiple(*numbers)
  return 0 if numbers.empty? || numbers.any?(&:zero?)
  return numbers.first.abs if numbers.length == 1
  
  result = numbers.first.abs
  numbers[1..-1].each do |num|
    result = lcm(result, num.abs)
  end
  
  result
end

def coprime?(a, b)
  gcd(a, b) == 1
end

def bezout_coefficients(a, b)
  gcd_val, x, y = gcd_extended(a, b)
  
  {
    gcd: gcd_val,
    x: x,
    y: y,
    equation: "#{gcd_val} = #{a} * #{x} + #{b} * #{y}"
  }
end

if __FILE__ == $0
  puts "GCD and LCM calculations:"
  
  test_pairs = [
    [48, 18],
    [56, 98],
    [17, 19],
    [100, 75],
    [0, 5],
    [-12, 8]
  ]
  
  test_pairs.each do |a, b|
    puts "Numbers: #{a}, #{b}"
    puts "  GCD (iterative): #{gcd(a, b)}"
    puts "  GCD (recursive): #{gcd_recursive(a, b)}"
    puts "  LCM: #{lcm(a, b)}"
    puts "  Coprime: #{coprime?(a, b)}"
    
    bezout = bezout_coefficients(a, b)
    puts "  Bezout: #{bezout[:equation]}"
    puts
  end
  
  puts "Multiple numbers:"
  numbers = [12, 18, 24, 36]
  puts "Numbers: #{numbers.inspect}"
  puts "GCD: #{gcd_multiple(*numbers)}"
  puts "LCM: #{lcm_multiple(*numbers)}"
end