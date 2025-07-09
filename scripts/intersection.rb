def intersection(arr1, arr2)
  set1 = arr1.to_set
  result = []
  
  arr2.each do |item|
    if set1.include?(item) && !result.include?(item)
      result << item
    end
  end
  
  result
end