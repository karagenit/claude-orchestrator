def average_array(arr)
  return 0.0 if arr.nil? || arr.empty?
  
  arr.sum.to_f / arr.length
end

def average_array_safe(arr)
  return nil if arr.nil? || arr.empty?
  
  numeric_elements = arr.select { |element| element.is_a?(Numeric) }
  return nil if numeric_elements.empty?
  
  numeric_elements.sum.to_f / numeric_elements.length
end

def average_array_with_precision(arr, precision = 2)
  return 0.0 if arr.nil? || arr.empty?
  
  average = arr.sum.to_f / arr.length
  average.round(precision)
end

def weighted_average(values, weights)
  return 0.0 if values.nil? || values.empty? || weights.nil? || weights.empty?
  return 0.0 if values.length != weights.length
  
  weighted_sum = values.zip(weights).map { |value, weight| value * weight }.sum
  total_weight = weights.sum
  
  return 0.0 if total_weight == 0
  
  weighted_sum.to_f / total_weight
end

def moving_average(arr, window_size)
  return [] if arr.nil? || arr.empty? || window_size <= 0 || window_size > arr.length
  
  moving_averages = []
  
  (0..arr.length - window_size).each do |i|
    window = arr[i, window_size]
    moving_averages << (window.sum.to_f / window_size)
  end
  
  moving_averages
end

def average_by_condition(arr, &condition)
  return 0.0 if arr.nil? || arr.empty?
  
  if block_given?
    filtered_arr = arr.select(&condition)
    return 0.0 if filtered_arr.empty?
    filtered_arr.sum.to_f / filtered_arr.length
  else
    average_array(arr)
  end
end

if __FILE__ == $0
  test_arrays = [
    [1, 2, 3, 4, 5],
    [10, -5, 3, -2, 8],
    [1.5, 2.7, 3.2, 4.1],
    [100, 200, 300],
    [1, "hello", 3, "world", 5]
  ]
  
  test_arrays.each do |arr|
    puts "Array: #{arr}"
    puts "Average: #{average_array(arr)}"
    puts "Safe average: #{average_array_safe(arr)}"
    puts "Precision 3: #{average_array_with_precision(arr, 3)}"
    puts "Average of positive: #{average_by_condition(arr) { |x| x.is_a?(Numeric) && x > 0 }}"
    puts "---"
  end
  
  puts "Weighted average example:"
  values = [85, 90, 78, 92, 88]
  weights = [0.2, 0.3, 0.1, 0.25, 0.15]
  puts "Values: #{values}, Weights: #{weights}"
  puts "Weighted average: #{weighted_average(values, weights)}"
  
  puts "Moving average example:"
  data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  puts "Data: #{data}"
  puts "Moving average (window 3): #{moving_average(data, 3)}"
end