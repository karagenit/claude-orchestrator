def selection_sort(arr)
  n = arr.length
  
  (0...n).each do |i|
    min_idx = i
    
    (i + 1...n).each do |j|
      min_idx = j if arr[j] < arr[min_idx]
    end
    
    arr[i], arr[min_idx] = arr[min_idx], arr[i] if min_idx != i
  end
  
  arr
end