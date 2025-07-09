def median(arr)
  return nil if arr.empty?
  
  sorted = arr.sort
  n = sorted.length
  
  if n.odd?
    sorted[n / 2]
  else
    (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0
  end
end