def insertion_sort(arr)
  return arr if arr.length <= 1
  
  sorted_arr = arr.dup
  
  (1...sorted_arr.length).each do |i|
    key = sorted_arr[i]
    j = i - 1
    
    while j >= 0 && sorted_arr[j] > key
      sorted_arr[j + 1] = sorted_arr[j]
      j -= 1
    end
    
    sorted_arr[j + 1] = key
  end
  
  sorted_arr
end

def insertion_sort_with_steps(arr)
  return { sorted: arr, steps: [] } if arr.length <= 1
  
  sorted_arr = arr.dup
  steps = []
  
  (1...sorted_arr.length).each do |i|
    key = sorted_arr[i]
    j = i - 1
    original_position = i
    
    while j >= 0 && sorted_arr[j] > key
      sorted_arr[j + 1] = sorted_arr[j]
      j -= 1
    end
    
    sorted_arr[j + 1] = key
    
    if j + 1 != original_position
      steps << {
        element: key,
        from: original_position,
        to: j + 1,
        array_state: sorted_arr.dup
      }
    end
  end
  
  { sorted: sorted_arr, steps: steps }
end

if __FILE__ == $0
  test_array = [64, 34, 25, 12, 22, 11, 90]
  puts "Original array: #{test_array}"
  puts "Sorted array: #{insertion_sort(test_array)}"
  
  result = insertion_sort_with_steps(test_array)
  puts "Sorted with steps: #{result[:sorted]}"
  puts "Steps taken: #{result[:steps].length}"
  
  result[:steps].each_with_index do |step, index|
    puts "Step #{index + 1}: Moved #{step[:element]} from position #{step[:from]} to #{step[:to]}"
  end
end