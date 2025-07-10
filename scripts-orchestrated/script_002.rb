def bubble_sort(arr)
  n = arr.length
  return arr if n <= 1
  
  loop do
    swapped = false
    
    (n - 1).times do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        swapped = true
      end
    end
    
    break unless swapped
  end
  
  arr
end

def bubble_sort_optimized(arr)
  n = arr.length
  return arr if n <= 1
  
  loop do
    new_n = 0
    
    (1...n).each do |i|
      if arr[i - 1] > arr[i]
        arr[i - 1], arr[i] = arr[i], arr[i - 1]
        new_n = i
      end
    end
    
    n = new_n
    break if n <= 1
  end
  
  arr
end

if __FILE__ == $0
  unsorted = [64, 34, 25, 12, 22, 11, 90]
  puts "Original array: #{unsorted}"
  puts "Bubble sort: #{bubble_sort(unsorted.dup)}"
  puts "Optimized bubble sort: #{bubble_sort_optimized(unsorted.dup)}"
end