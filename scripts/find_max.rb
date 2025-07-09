def find_max(arr)
  return nil if arr.empty?
  
  max = arr[0]
  
  arr.each do |num|
    max = num if num > max
  end
  
  max
end