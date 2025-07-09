def chunk_array(arr, size)
  return [] if arr.empty? || size <= 0
  
  chunks = []
  i = 0
  
  while i < arr.length
    chunk = arr[i, size]
    chunks << chunk
    i += size
  end
  
  chunks
end