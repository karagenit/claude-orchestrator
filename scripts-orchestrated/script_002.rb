def quicksort(arr)
  return arr if arr.length <= 1
  
  pivot = arr[arr.length / 2]
  left = arr.select { |x| x < pivot }
  middle = arr.select { |x| x == pivot }
  right = arr.select { |x| x > pivot }
  
  quicksort(left) + middle + quicksort(right)
end

def quicksort_inplace(arr, low = 0, high = arr.length - 1)
  if low < high
    pivot_index = partition(arr, low, high)
    quicksort_inplace(arr, low, pivot_index - 1)
    quicksort_inplace(arr, pivot_index + 1, high)
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
  unsorted = [64, 34, 25, 12, 22, 11, 90]
  puts "Original array: #{unsorted}"
  puts "Quicksort: #{quicksort(unsorted.dup)}"
  puts "In-place quicksort: #{quicksort_inplace(unsorted.dup)}"
end