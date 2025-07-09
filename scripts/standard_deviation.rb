def standard_deviation(arr)
  return 0 if arr.empty? || arr.length == 1
  
  mean = arr.sum.to_f / arr.length
  variance = arr.map { |x| (x - mean) ** 2 }.sum / arr.length
  
  Math.sqrt(variance)
end