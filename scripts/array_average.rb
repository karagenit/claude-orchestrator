def array_average(arr)
  return 0 if arr.empty?
  
  sum = 0
  arr.each { |num| sum += num }
  sum.to_f / arr.length
end