def combinations(n, r)
  return 0 if r < 0 || r > n
  return 1 if r == 0 || r == n
  
  r = n - r if r > n - r
  
  result = 1
  (1..r).each do |i|
    result = result * (n - i + 1) / i
  end
  
  result
end

def combinations_with_repetition(n, r)
  return 0 if r < 0 || n <= 0
  return 1 if r == 0
  
  combinations(n + r - 1, r)
end

def permutations(n, r)
  return 0 if r < 0 || r > n
  return 1 if r == 0
  
  result = 1
  (n - r + 1..n).each do |i|
    result *= i
  end
  
  result
end

def generate_combinations(arr, r)
  return [[]] if r == 0
  return [] if arr.empty?
  
  result = []
  first = arr[0]
  rest = arr[1..-1]
  
  generate_combinations(rest, r - 1).each do |combo|
    result << [first] + combo
  end
  
  result += generate_combinations(rest, r)
  result
end

def pascal_triangle_row(n)
  row = [1]
  (1..n).each do |i|
    row << combinations(n, i)
  end
  row
end

if __FILE__ == $0
  puts "Combinations C(5,2): #{combinations(5, 2)}"
  puts "Combinations C(10,3): #{combinations(10, 3)}"
  puts "Permutations P(5,2): #{permutations(5, 2)}"
  puts "Generate combinations of [1,2,3,4] choose 2: #{generate_combinations([1,2,3,4], 2)}"
  puts "Pascal triangle row 5: #{pascal_triangle_row(5)}"
end