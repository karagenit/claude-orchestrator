def array_intersection(arr1, arr2)
  return [] if arr1.nil? || arr2.nil? || arr1.empty? || arr2.empty?
  
  arr1 & arr2
end

def array_intersection_manual(arr1, arr2)
  return [] if arr1.nil? || arr2.nil? || arr1.empty? || arr2.empty?
  
  result = []
  arr1.each do |element|
    if arr2.include?(element) && !result.include?(element)
      result << element
    end
  end
  result
end

def array_intersection_with_duplicates(arr1, arr2)
  return [] if arr1.nil? || arr2.nil? || arr1.empty? || arr2.empty?
  
  result = []
  arr1.each do |element|
    if arr2.include?(element)
      result << element
    end
  end
  result
end

def array_intersection_multiple(*arrays)
  return [] if arrays.nil? || arrays.empty? || arrays.any?(&:nil?)
  
  arrays.reduce(:&) || []
end

def array_intersection_with_count(arr1, arr2)
  return { intersection: [], counts: {} } if arr1.nil? || arr2.nil? || arr1.empty? || arr2.empty?
  
  intersection = arr1 & arr2
  counts = {}
  
  intersection.each do |element|
    counts[element] = {
      arr1_count: arr1.count(element),
      arr2_count: arr2.count(element),
      min_count: [arr1.count(element), arr2.count(element)].min
    }
  end
  
  { intersection: intersection, counts: counts }
end

def array_intersection_preserve_order(arr1, arr2)
  return [] if arr1.nil? || arr2.nil? || arr1.empty? || arr2.empty?
  
  result = []
  seen = {}
  
  arr1.each do |element|
    if arr2.include?(element) && !seen[element]
      result << element
      seen[element] = true
    end
  end
  
  result
end

def array_intersection_case_insensitive(arr1, arr2)
  return [] if arr1.nil? || arr2.nil? || arr1.empty? || arr2.empty?
  
  arr1_lower = arr1.map { |el| el.is_a?(String) ? el.downcase : el }
  arr2_lower = arr2.map { |el| el.is_a?(String) ? el.downcase : el }
  
  intersection_lower = arr1_lower & arr2_lower
  
  result = []
  intersection_lower.each do |element|
    original = arr1.find { |el| (el.is_a?(String) ? el.downcase : el) == element }
    result << original if original
  end
  
  result
end

if __FILE__ == $0
  test_cases = [
    [[1, 2, 3, 4, 5], [3, 4, 5, 6, 7]],
    [["apple", "banana", "cherry"], ["banana", "cherry", "date"]],
    [["Hello", "World"], ["hello", "world", "test"]],
    [[1, 2, 2, 3, 3, 3], [2, 2, 3, 4, 4]],
    [[], [1, 2, 3]],
    [[1, 2, 3], [4, 5, 6]]
  ]
  
  test_cases.each do |arr1, arr2|
    puts "Array 1: #{arr1}"
    puts "Array 2: #{arr2}"
    puts "Intersection: #{array_intersection(arr1, arr2)}"
    puts "Manual intersection: #{array_intersection_manual(arr1, arr2)}"
    puts "With duplicates: #{array_intersection_with_duplicates(arr1, arr2)}"
    puts "Preserve order: #{array_intersection_preserve_order(arr1, arr2)}"
    puts "Case insensitive: #{array_intersection_case_insensitive(arr1, arr2)}"
    puts "With count: #{array_intersection_with_count(arr1, arr2)}"
    puts "---"
  end
  
  puts "Multiple arrays intersection:"
  arr_a = [1, 2, 3, 4, 5]
  arr_b = [3, 4, 5, 6, 7]
  arr_c = [4, 5, 6, 7, 8]
  puts "Arrays: #{arr_a}, #{arr_b}, #{arr_c}"
  puts "Intersection: #{array_intersection_multiple(arr_a, arr_b, arr_c)}"
end