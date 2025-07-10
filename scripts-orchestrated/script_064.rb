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

def matrix_transpose_in_place(matrix)
  return matrix if matrix.empty? || matrix.length != matrix[0].length
  
  n = matrix.length
  
  (0...n).each do |i|
    (i+1...n).each do |j|
      matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
    end
  end
  
  matrix
end

def is_symmetric(matrix)
  return false if matrix.empty? || matrix.length != matrix[0].length
  
  n = matrix.length
  
  (0...n).each do |i|
    (0...n).each do |j|
      return false if matrix[i][j] != matrix[j][i]
    end
  end
  
  true
end

def matrix_transpose_optimized(matrix)
  return matrix.map(&:dup) if matrix.empty?
  
  rows = matrix.length
  cols = matrix[0].length
  
  if rows == cols
    result = matrix.map(&:dup)
    matrix_transpose_in_place(result)
    return result
  end
  
  matrix_transpose(matrix)
end

def conjugate_transpose(matrix)
  return [] if matrix.empty?
  
  rows = matrix.length
  cols = matrix[0].length
  
  result = Array.new(cols) { Array.new(rows) }
  
  (0...rows).each do |i|
    (0...cols).each do |j|
      element = matrix[i][j]
      if element.respond_to?(:conjugate)
        result[j][i] = element.conjugate
      else
        result[j][i] = element
      end
    end
  end
  
  result
end

def trace(matrix)
  return 0 if matrix.empty? || matrix.length != matrix[0].length
  
  trace_sum = 0
  (0...matrix.length).each do |i|
    trace_sum += matrix[i][i]
  end
  
  trace_sum
end

def is_diagonal(matrix)
  return false if matrix.empty? || matrix.length != matrix[0].length
  
  n = matrix.length
  
  (0...n).each do |i|
    (0...n).each do |j|
      return false if i != j && matrix[i][j] != 0
    end
  end
  
  true
end

def matrix_minor(matrix, row, col)
  return [] if matrix.empty?
  
  result = []
  matrix.each_with_index do |matrix_row, i|
    next if i == row
    new_row = []
    matrix_row.each_with_index do |element, j|
      new_row << element unless j == col
    end
    result << new_row
  end
  
  result
end

if __FILE__ == $0
  matrix = [[1, 2, 3], [4, 5, 6]]
  puts "Original matrix:"
  matrix.each { |row| puts row.inspect }
  
  transposed = matrix_transpose(matrix)
  puts "Transposed matrix:"
  transposed.each { |row| puts row.inspect }
  
  square_matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  puts "Square matrix symmetric: #{is_symmetric(square_matrix)}"
  puts "Square matrix trace: #{trace(square_matrix)}"
end