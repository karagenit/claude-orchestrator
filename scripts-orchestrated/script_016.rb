def sum_array(arr)
  return 0 if arr.nil? || arr.empty?
  
  arr.sum
end

def sum_array_manual(arr)
  return 0 if arr.nil? || arr.empty?
  
  total = 0
  arr.each { |element| total += element }
  total
end

def sum_array_recursive(arr)
  return 0 if arr.nil? || arr.empty?
  return arr[0] if arr.length == 1
  
  arr[0] + sum_array_recursive(arr[1..-1])
end

def sum_array_with_condition(arr, &condition)
  return 0 if arr.nil? || arr.empty?
  
  if block_given?
    arr.select(&condition).sum
  else
    arr.sum
  end
end

def sum_nested_array(arr)
  return 0 if arr.nil? || arr.empty?
  
  total = 0
  
  arr.each do |element|
    if element.is_a?(Array)
      total += sum_nested_array(element)
    elsif element.is_a?(Numeric)
      total += element
    end
  end
  
  total
end

def sum_with_initial_value(arr, initial = 0)
  return initial if arr.nil? || arr.empty?
  
  arr.reduce(initial) { |sum, element| sum + element }
end

if __FILE__ == $0
  test_arrays = [
    [1, 2, 3, 4, 5],
    [10, -5, 3, -2, 8],
    [1.5, 2.7, 3.2, 4.1],
    [1, [2, 3], [4, [5, 6]]],
    []
  ]
  
  test_arrays.each do |arr|
    puts "Array: #{arr}"
    puts "Sum: #{sum_array(arr)}"
    puts "Manual sum: #{sum_array_manual(arr)}"
    puts "Recursive sum: #{sum_array_recursive(arr)}"
    puts "Sum with initial 100: #{sum_with_initial_value(arr, 100)}"
    if arr.any? { |el| el.is_a?(Array) }
      puts "Nested sum: #{sum_nested_array(arr)}"
    end
    puts "Sum of positive numbers: #{sum_array_with_condition(arr) { |x| x > 0 }}"
    puts "---"
  end
end