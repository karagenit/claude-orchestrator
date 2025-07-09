def rotate_array(arr, k)
  return arr if arr.empty? || k == 0
  
  n = arr.length
  k = k % n
  
  return arr if k == 0
  
  arr[-k..-1] + arr[0...-k]
end