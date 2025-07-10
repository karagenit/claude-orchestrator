def binary_search(arr, target)
  left = 0
  right = arr.length - 1
  
  while left <= right
    mid = (left + right) / 2
    
    if arr[mid] == target
      return mid
    elsif arr[mid] < target
      left = mid + 1
    else
      right = mid - 1
    end
  end
  
  -1
end

def binary_search_recursive(arr, target, left = 0, right = arr.length - 1)
  return -1 if left > right
  
  mid = (left + right) / 2
  
  if arr[mid] == target
    mid
  elsif arr[mid] < target
    binary_search_recursive(arr, target, mid + 1, right)
  else
    binary_search_recursive(arr, target, left, mid - 1)
  end
end

if __FILE__ == $0
  sorted_array = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]
  puts "Array: #{sorted_array}"
  puts "Binary search for 7: #{binary_search(sorted_array, 7)}"
  puts "Binary search for 4: #{binary_search(sorted_array, 4)}"
  puts "Recursive binary search for 13: #{binary_search_recursive(sorted_array, 13)}"
end