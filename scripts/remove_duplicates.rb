def remove_duplicates(arr)
  seen = {}
  result = []
  
  arr.each do |item|
    unless seen[item]
      result << item
      seen[item] = true
    end
  end
  
  result
end