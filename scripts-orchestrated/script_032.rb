def radix_sort(arr)
  return arr if arr.length <= 1
  
  array = arr.dup
  max_value = array.max
  
  # Handle negative numbers by finding offset
  min_value = array.min
  offset = min_value < 0 ? -min_value : 0
  
  # Apply offset to make all numbers non-negative
  array.map! { |num| num + offset }
  max_value += offset
  
  # Get number of digits in max value
  max_digits = max_value.to_s.length
  
  # Perform counting sort for each digit
  (0...max_digits).each do |digit_pos|
    counting_sort_by_digit(array, digit_pos)
  end
  
  # Remove offset to restore original values
  array.map! { |num| num - offset }
  
  array
end

def counting_sort_by_digit(arr, digit_pos)
  n = arr.length
  output = Array.new(n)
  count = Array.new(10, 0)
  
  # Count occurrences of each digit
  arr.each do |num|
    digit = get_digit(num, digit_pos)
    count[digit] += 1
  end
  
  # Change count[i] to actual position
  (1...10).each do |i|
    count[i] += count[i - 1]
  end
  
  # Build output array
  (n - 1).downto(0) do |i|
    digit = get_digit(arr[i], digit_pos)
    output[count[digit] - 1] = arr[i]
    count[digit] -= 1
  end
  
  # Copy output array to original array
  arr.replace(output)
end

def get_digit(num, digit_pos)
  (num / (10 ** digit_pos)) % 10
end