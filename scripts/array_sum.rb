def array_sum(arr)
  return 0 if arr.empty?
  
  sum = 0
  arr.each { |num| sum += num }
  sum
end