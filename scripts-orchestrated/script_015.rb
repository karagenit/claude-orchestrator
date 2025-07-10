def remove_duplicates(arr)
  return [] if arr.nil? || arr.empty?
  
  arr.uniq
end

def remove_duplicates_preserve_order(arr)
  return [] if arr.nil? || arr.empty?
  
  seen = {}
  result = []
  
  arr.each do |element|
    unless seen[element]
      seen[element] = true
      result << element
    end
  end
  
  result
end

def remove_duplicates_manual(arr)
  return [] if arr.nil? || arr.empty?
  
  result = []
  
  arr.each do |element|
    result << element unless result.include?(element)
  end
  
  result
end

def remove_duplicates_case_insensitive(arr)
  return [] if arr.nil? || arr.empty?
  
  seen = {}
  result = []
  
  arr.each do |element|
    key = element.is_a?(String) ? element.downcase : element
    unless seen[key]
      seen[key] = true
      result << element
    end
  end
  
  result
end

def remove_duplicates_with_count(arr)
  return { unique: [], duplicates: [], counts: {} } if arr.nil? || arr.empty?
  
  counts = {}
  arr.each { |element| counts[element] = counts.fetch(element, 0) + 1 }
  
  unique = counts.select { |_, count| count == 1 }.keys
  duplicates = counts.select { |_, count| count > 1 }.keys
  
  { unique: unique, duplicates: duplicates, counts: counts }
end

if __FILE__ == $0
  test_arrays = [
    [1, 2, 2, 3, 4, 4, 5],
    ["apple", "banana", "apple", "cherry", "banana"],
    ["Hello", "hello", "HELLO", "world"],
    [1, 1, 1, 2, 2, 3, 4, 4, 4, 4],
    []
  ]
  
  test_arrays.each do |arr|
    puts "Original: #{arr}"
    puts "Unique: #{remove_duplicates(arr)}"
    puts "Preserve order: #{remove_duplicates_preserve_order(arr)}"
    puts "Case insensitive: #{remove_duplicates_case_insensitive(arr)}"
    puts "With count info: #{remove_duplicates_with_count(arr)}"
    puts "---"
  end
end