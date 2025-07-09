def flatten_array(arr)
  result = []
  
  arr.each do |item|
    if item.is_a?(Array)
      result.concat(flatten_array(item))
    else
      result << item
    end
  end
  
  result
end