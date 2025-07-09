def union(arr1, arr2)
  result = []
  seen = {}
  
  (arr1 + arr2).each do |item|
    unless seen[item]
      result << item
      seen[item] = true
    end
  end
  
  result
end