def heap_sort(arr)
  return arr if arr.length <= 1
  
  array = arr.dup
  n = array.length
  
  # Build max heap
  (n / 2 - 1).downto(0) do |i|
    heapify(array, n, i)
  end
  
  # Extract elements one by one
  (n - 1).downto(1) do |i|
    # Move current root to end
    array[0], array[i] = array[i], array[0]
    
    # Call heapify on the reduced heap
    heapify(array, i, 0)
  end
  
  array
end

def heapify(arr, n, i)
  largest = i
  left = 2 * i + 1
  right = 2 * i + 2
  
  # If left child is larger than root
  if left < n && arr[left] > arr[largest]
    largest = left
  end
  
  # If right child is larger than largest so far
  if right < n && arr[right] > arr[largest]
    largest = right
  end
  
  # If largest is not root
  if largest != i
    arr[i], arr[largest] = arr[largest], arr[i]
    
    # Recursively heapify the affected sub-tree
    heapify(arr, n, largest)
  end
end