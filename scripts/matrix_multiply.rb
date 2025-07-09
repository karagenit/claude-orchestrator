def matrix_multiply(a, b)
  return nil if a.empty? || b.empty?
  return nil if a[0].length != b.length
  
  rows_a = a.length
  cols_a = a[0].length
  cols_b = b[0].length
  
  result = Array.new(rows_a) { Array.new(cols_b, 0) }
  
  (0...rows_a).each do |i|
    (0...cols_b).each do |j|
      (0...cols_a).each do |k|
        result[i][j] += a[i][k] * b[k][j]
      end
    end
  end
  
  result
end