def quicksort(arr)
  return arr if arr.length <= 1
  
  pivot = arr[arr.length / 2]
  left = []
  right = []
  equal = []
  
  arr.each do |element|
    if element < pivot
      left << element
    elsif element > pivot
      right << element
    else
      equal << element
    end
  end
  
  quicksort(left) + equal + quicksort(right)
end

def quicksort_inplace(arr, low = 0, high = arr.length - 1)
  if low < high
    partition_index = partition(arr, low, high)
    quicksort_inplace(arr, low, partition_index - 1)
    quicksort_inplace(arr, partition_index + 1, high)
  end
  arr
end

def partition(arr, low, high)
  pivot = arr[high]
  i = low - 1
  
  (low...high).each do |j|
    if arr[j] <= pivot
      i += 1
      arr[i], arr[j] = arr[j], arr[i]
    end
  end
  
  arr[i + 1], arr[high] = arr[high], arr[i + 1]
  i + 1
end

if __FILE__ == $0
  test_array = [64, 34, 25, 12, 22, 11, 90]
  puts "Original array: #{test_array}"
  puts "Quicksorted: #{quicksort(test_array.dup)}"
  puts "In-place quicksorted: #{quicksort_inplace(test_array.dup)}"
end