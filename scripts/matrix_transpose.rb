def matrix_transpose(matrix)
  return [] if matrix.empty?
  
  rows = matrix.length
  cols = matrix[0].length
  
  result = Array.new(cols) { Array.new(rows) }
  
  (0...rows).each do |i|
    (0...cols).each do |j|
      result[j][i] = matrix[i][j]
    end
  end
  
  result
end