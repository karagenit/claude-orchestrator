def linear_search(arr, target)
  arr.each_with_index do |element, index|
    return index if element == target
  end
  -1
end

def linear_search_all(arr, target)
  indices = []
  arr.each_with_index do |element, index|
    indices << index if element == target
  end
  indices
end

def linear_search_with_comparison(arr, target, &comparison)
  if block_given?
    arr.each_with_index do |element, index|
      return index if comparison.call(element, target)
    end
  else
    return linear_search(arr, target)
  end
  -1
end

def linear_search_last(arr, target)
  last_index = -1
  arr.each_with_index do |element, index|
    last_index = index if element == target
  end
  last_index
end

if __FILE__ == $0
  test_array = [5, 2, 8, 12, 1, 9, 4, 2, 7]
  target = 2
  
  puts "Array: #{test_array}"
  puts "Searching for: #{target}"
  puts "First occurrence at index: #{linear_search(test_array, target)}"
  puts "All occurrences at indices: #{linear_search_all(test_array, target)}"
  puts "Last occurrence at index: #{linear_search_last(test_array, target)}"
  puts "Custom search (greater than 5): #{linear_search_with_comparison(test_array, 5) { |a, b| a > b }}"
end