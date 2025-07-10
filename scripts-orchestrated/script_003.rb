def merge_sort(arr)
  return arr if arr.length <= 1
  
  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..-1])
  
  merge(left, right)
end

def merge(left, right)
  result = []
  left_index = 0
  right_index = 0
  
  while left_index < left.length && right_index < right.length
    if left[left_index] <= right[right_index]
      result << left[left_index]
      left_index += 1
    else
      result << right[right_index]
      right_index += 1
    end
  end
  
  result.concat(left[left_index..-1]) if left_index < left.length
  result.concat(right[right_index..-1]) if right_index < right.length
  
  result
end

def merge_sort_iterative(arr)
  return arr if arr.length <= 1
  
  width = 1
  n = arr.length
  
  while width < n
    left = 0
    
    while left < n - 1
      mid = [left + width - 1, n - 1].min
      right = [left + width * 2 - 1, n - 1].min
      
      if mid < right
        merge_subarrays(arr, left, mid, right)
      end
      
      left += width * 2
    end
    
    width *= 2
  end
  
  arr
end

def merge_subarrays(arr, left, mid, right)
  left_arr = arr[left..mid]
  right_arr = arr[mid + 1..right]
  
  i = j = 0
  k = left
  
  while i < left_arr.length && j < right_arr.length
    if left_arr[i] <= right_arr[j]
      arr[k] = left_arr[i]
      i += 1
    else
      arr[k] = right_arr[j]
      j += 1
    end
    k += 1
  end
  
  while i < left_arr.length
    arr[k] = left_arr[i]
    i += 1
    k += 1
  end
  
  while j < right_arr.length
    arr[k] = right_arr[j]
    j += 1
    k += 1
  end
end

if __FILE__ == $0
  unsorted = [64, 34, 25, 12, 22, 11, 90]
  puts "Original array: #{unsorted}"
  puts "Merge sort: #{merge_sort(unsorted.dup)}"
  puts "Iterative merge sort: #{merge_sort_iterative(unsorted.dup)}"
end