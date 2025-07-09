def linear_search(arr, target)
  arr.each_with_index do |item, index|
    return index if item == target
  end
  
  -1
end