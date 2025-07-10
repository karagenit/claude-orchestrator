def selection_sort(arr)
  return arr if arr.length <= 1
  
  sorted_arr = arr.dup
  n = sorted_arr.length
  
  (0...n).each do |i|
    min_index = i
    
    (i + 1...n).each do |j|
      if sorted_arr[j] < sorted_arr[min_index]
        min_index = j
      end
    end
    
    if min_index != i
      sorted_arr[i], sorted_arr[min_index] = sorted_arr[min_index], sorted_arr[i]
    end
  end
  
  sorted_arr
end

def selection_sort_with_comparisons(arr)
  return { sorted: arr, comparisons: 0 } if arr.length <= 1
  
  sorted_arr = arr.dup
  n = sorted_arr.length
  comparisons = 0
  
  (0...n).each do |i|
    min_index = i
    
    (i + 1...n).each do |j|
      comparisons += 1
      if sorted_arr[j] < sorted_arr[min_index]
        min_index = j
      end
    end
    
    if min_index != i
      sorted_arr[i], sorted_arr[min_index] = sorted_arr[min_index], sorted_arr[i]
    end
  end
  
  { sorted: sorted_arr, comparisons: comparisons }
end

if __FILE__ == $0
  test_array = [64, 34, 25, 12, 22, 11, 90]
  puts "Original array: #{test_array}"
  puts "Sorted array: #{selection_sort(test_array)}"
  
  result = selection_sort_with_comparisons(test_array)
  puts "Sorted with stats: #{result[:sorted]}"
  puts "Total comparisons: #{result[:comparisons]}"
end