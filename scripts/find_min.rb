def find_min(arr)
  return nil if arr.empty?
  
  min = arr[0]
  
  arr.each do |num|
    min = num if num < min
  end
  
  min
end