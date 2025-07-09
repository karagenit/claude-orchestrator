def variance(arr)
  return 0 if arr.empty? || arr.length == 1
  
  mean = arr.sum.to_f / arr.length
  arr.map { |x| (x - mean) ** 2 }.sum / arr.length
end