def difference(arr1, arr2)
  set2 = arr2.to_set
  result = []
  
  arr1.each do |item|
    result << item unless set2.include?(item)
  end
  
  result
end