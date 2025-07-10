def matrix_multiply(matrix_a, matrix_b)
  return nil if matrix_a.empty? || matrix_b.empty?
  
  rows_a = matrix_a.length
  cols_a = matrix_a[0].length
  rows_b = matrix_b.length
  cols_b = matrix_b[0].length
  
  return nil if cols_a != rows_b
  
  result = Array.new(rows_a) { Array.new(cols_b, 0) }
  
  (0...rows_a).each do |i|
    (0...cols_b).each do |j|
      (0...cols_a).each do |k|
        result[i][j] += matrix_a[i][k] * matrix_b[k][j]
      end
    end
  end
  
  result
end

def matrix_multiply_strassen(a, b)
  return matrix_multiply(a, b) if a.length <= 2
  
  n = a.length
  return matrix_multiply(a, b) if n % 2 != 0
  
  mid = n / 2
  
  a11 = a[0...mid].map { |row| row[0...mid] }
  a12 = a[0...mid].map { |row| row[mid...n] }
  a21 = a[mid...n].map { |row| row[0...mid] }
  a22 = a[mid...n].map { |row| row[mid...n] }
  
  b11 = b[0...mid].map { |row| row[0...mid] }
  b12 = b[0...mid].map { |row| row[mid...n] }
  b21 = b[mid...n].map { |row| row[0...mid] }
  b22 = b[mid...n].map { |row| row[mid...n] }
  
  p1 = matrix_multiply_strassen(a11, matrix_subtract(b12, b22))
  p2 = matrix_multiply_strassen(matrix_add(a11, a12), b22)
  p3 = matrix_multiply_strassen(matrix_add(a21, a22), b11)
  p4 = matrix_multiply_strassen(a22, matrix_subtract(b21, b11))
  p5 = matrix_multiply_strassen(matrix_add(a11, a22), matrix_add(b11, b22))
  p6 = matrix_multiply_strassen(matrix_subtract(a12, a22), matrix_add(b21, b22))
  p7 = matrix_multiply_strassen(matrix_subtract(a11, a21), matrix_add(b11, b12))
  
  c11 = matrix_subtract(matrix_add(matrix_add(p5, p4), p6), p2)
  c12 = matrix_add(p1, p2)
  c21 = matrix_add(p3, p4)
  c22 = matrix_subtract(matrix_subtract(matrix_add(p5, p1), p3), p7)
  
  result = Array.new(n) { Array.new(n) }
  (0...mid).each do |i|
    (0...mid).each do |j|
      result[i][j] = c11[i][j]
      result[i][j + mid] = c12[i][j]
      result[i + mid][j] = c21[i][j]
      result[i + mid][j + mid] = c22[i][j]
    end
  end
  
  result
end

def matrix_add(a, b)
  result = Array.new(a.length) { Array.new(a[0].length) }
  (0...a.length).each do |i|
    (0...a[0].length).each do |j|
      result[i][j] = a[i][j] + b[i][j]
    end
  end
  result
end

def matrix_subtract(a, b)
  result = Array.new(a.length) { Array.new(a[0].length) }
  (0...a.length).each do |i|
    (0...a[0].length).each do |j|
      result[i][j] = a[i][j] - b[i][j]
    end
  end
  result
end

if __FILE__ == $0
  a = [[1, 2], [3, 4]]
  b = [[5, 6], [7, 8]]
  puts "Matrix A:"
  a.each { |row| puts row.inspect }
  puts "Matrix B:"
  b.each { |row| puts row.inspect }
  puts "A * B:"
  result = matrix_multiply(a, b)
  result.each { |row| puts row.inspect }
end