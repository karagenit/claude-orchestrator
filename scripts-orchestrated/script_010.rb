def find_max(arr)
  return nil if arr.nil? || arr.empty?
  
  max_value = arr.first
  
  arr.each do |element|
    max_value = element if element > max_value
  end
  
  max_value
end

def find_max_with_index(arr)
  return [nil, nil] if arr.nil? || arr.empty?
  
  max_value = arr.first
  max_index = 0
  
  arr.each_with_index do |element, index|
    if element > max_value
      max_value = element
      max_index = index
    end
  end
  
  [max_value, max_index]
end

def find_max_recursive(arr, index = 0)
  return nil if arr.nil? || arr.empty?
  return arr[index] if index == arr.length - 1
  
  max_of_rest = find_max_recursive(arr, index + 1)
  
  arr[index] > max_of_rest ? arr[index] : max_of_rest
end

def find_max_divide_conquer(arr, left = 0, right = arr.length - 1)
  return nil if arr.nil? || arr.empty?
  return arr[left] if left == right
  
  mid = (left + right) / 2
  
  left_max = find_max_divide_conquer(arr, left, mid)
  right_max = find_max_divide_conquer(arr, mid + 1, right)
  
  left_max > right_max ? left_max : right_max
end

def find_max_with_condition(arr, &condition)
  return nil if arr.nil? || arr.empty?
  
  filtered = block_given? ? arr.select(&condition) : arr
  return nil if filtered.empty?
  
  find_max(filtered)
end

def find_k_largest(arr, k)
  return [] if arr.nil? || arr.empty? || k <= 0
  
  arr.sort.reverse.take(k)
end

def find_k_largest_heap(arr, k)
  return [] if arr.nil? || arr.empty? || k <= 0
  
  require 'algorithms'
  heap = Containers::MaxHeap.new
  
  arr.each { |element| heap.push(element) }
  
  result = []
  k.times do
    break if heap.empty?
    result << heap.pop
  end
  
  result
rescue LoadError
  find_k_largest(arr, k)
end

def find_max_subarray_sum(arr)
  return 0 if arr.nil? || arr.empty?
  
  max_sum = arr.first
  current_sum = arr.first
  
  (1...arr.length).each do |i|
    current_sum = [arr[i], current_sum + arr[i]].max
    max_sum = [max_sum, current_sum].max
  end
  
  max_sum
end

def find_max_product_subarray(arr)
  return 0 if arr.nil? || arr.empty?
  
  max_product = arr.first
  min_product = arr.first
  result = arr.first
  
  (1...arr.length).each do |i|
    if arr[i] < 0
      max_product, min_product = min_product, max_product
    end
    
    max_product = [arr[i], max_product * arr[i]].max
    min_product = [arr[i], min_product * arr[i]].min
    
    result = [result, max_product].max
  end
  
  result
end

if __FILE__ == $0
  puts "Finding maximum values:"
  
  test_arrays = [
    [3, 7, 1, 9, 2, 8],
    [-5, -2, -8, -1, -9],
    [42],
    [],
    [1, 1, 1, 1],
    [9, 7, 5, 3, 1]
  ]
  
  test_arrays.each do |arr|
    puts "Array: #{arr.inspect}"
    puts "  Max: #{find_max(arr)}"
    puts "  Max with index: #{find_max_with_index(arr)}"
    puts "  Max recursive: #{find_max_recursive(arr)}"
    puts "  Max divide & conquer: #{find_max_divide_conquer(arr)}" unless arr.empty?
    puts
  end
  
  numbers = [3, 7, 1, 9, 2, 8, 5, 4, 6]
  puts "Numbers: #{numbers.inspect}"
  puts "3 largest: #{find_k_largest(numbers, 3)}"
  puts "Max even: #{find_max_with_condition(numbers) { |n| n.even? }}"
  puts "Max odd: #{find_max_with_condition(numbers) { |n| n.odd? }}"
  
  puts "\nSubarray problems:"
  subarray_test = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
  puts "Array: #{subarray_test.inspect}"
  puts "Max subarray sum: #{find_max_subarray_sum(subarray_test)}"
  
  product_test = [2, 3, -2, 4]
  puts "Array: #{product_test.inspect}"
  puts "Max product subarray: #{find_max_product_subarray(product_test)}"
end