def min_max(arr)
  return [nil, nil] if arr.nil? || arr.empty?
  
  [arr.min, arr.max]
end

def min_max_manual(arr)
  return [nil, nil] if arr.nil? || arr.empty?
  
  min_val = arr[0]
  max_val = arr[0]
  
  arr.each do |element|
    min_val = element if element < min_val
    max_val = element if element > max_val
  end
  
  [min_val, max_val]
end

def min_max_with_indices(arr)
  return { min: nil, max: nil, min_index: nil, max_index: nil } if arr.nil? || arr.empty?
  
  min_val = arr[0]
  max_val = arr[0]
  min_index = 0
  max_index = 0
  
  arr.each_with_index do |element, index|
    if element < min_val
      min_val = element
      min_index = index
    end
    if element > max_val
      max_val = element
      max_index = index
    end
  end
  
  { min: min_val, max: max_val, min_index: min_index, max_index: max_index }
end

def min_max_by_condition(arr, &condition)
  return [nil, nil] if arr.nil? || arr.empty?
  
  if block_given?
    filtered_arr = arr.select(&condition)
    return [nil, nil] if filtered_arr.empty?
    [filtered_arr.min, filtered_arr.max]
  else
    min_max(arr)
  end
end

def min_max_range(arr)
  return 0 if arr.nil? || arr.empty?
  
  min_val, max_val = min_max(arr)
  return 0 if min_val.nil? || max_val.nil?
  
  max_val - min_val
end

def min_max_normalize(arr)
  return [] if arr.nil? || arr.empty?
  
  min_val, max_val = min_max(arr)
  return arr if min_val == max_val
  
  range = max_val - min_val
  arr.map { |element| (element - min_val).to_f / range }
end

if __FILE__ == $0
  test_arrays = [
    [5, 2, 8, 1, 9, 3],
    [-10, -5, 0, 5, 10],
    [1.5, 2.7, 0.3, 4.1, 3.8],
    [100],
    [7, 7, 7, 7, 7],
    []
  ]
  
  test_arrays.each do |arr|
    puts "Array: #{arr}"
    puts "Min/Max: #{min_max(arr)}"
    puts "Manual Min/Max: #{min_max_manual(arr)}"
    puts "With indices: #{min_max_with_indices(arr)}"
    puts "Range: #{min_max_range(arr)}"
    puts "Positive numbers only: #{min_max_by_condition(arr) { |x| x > 0 }}"
    puts "Normalized: #{min_max_normalize(arr)}"
    puts "---"
  end
end