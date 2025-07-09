def symmetric_difference(arr1, arr2)
  set1 = arr1.to_set
  set2 = arr2.to_set
  result = []
  
  arr1.each do |item|
    result << item unless set2.include?(item)
  end
  
  arr2.each do |item|
    result << item unless set1.include?(item)
  end
  
  result.uniq
end