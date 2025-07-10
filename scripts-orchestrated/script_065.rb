def determinant(matrix)
  return nil if matrix.empty? || matrix.length != matrix[0].length
  
  n = matrix.length
  return matrix[0][0] if n == 1
  return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0] if n == 2
  
  det = 0
  (0...n).each do |col|
    cofactor = (-1) ** col
    minor_matrix = matrix_minor(matrix, 0, col)
    det += cofactor * matrix[0][col] * determinant(minor_matrix)
  end
  
  det
end

def determinant_lu(matrix)
  return nil if matrix.empty? || matrix.length != matrix[0].length
  
  n = matrix.length
  lu_matrix = matrix.map(&:dup)
  determinant_value = 1
  
  (0...n).each do |i|
    max_row = i
    (i+1...n).each do |k|
      max_row = k if lu_matrix[k][i].abs > lu_matrix[max_row][i].abs
    end
    
    if max_row != i
      lu_matrix[i], lu_matrix[max_row] = lu_matrix[max_row], lu_matrix[i]
      determinant_value *= -1
    end
    
    return 0 if lu_matrix[i][i] == 0
    
    determinant_value *= lu_matrix[i][i]
    
    (i+1...n).each do |k|
      factor = lu_matrix[k][i].to_f / lu_matrix[i][i]
      (i...n).each do |j|
        lu_matrix[k][j] -= factor * lu_matrix[i][j]
      end
    end
  end
  
  determinant_value.round(10)
end

def matrix_minor(matrix, row, col)
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

def cofactor_matrix(matrix)
  return nil if matrix.empty? || matrix.length != matrix[0].length
  
  n = matrix.length
  cofactor_mat = Array.new(n) { Array.new(n) }
  
  (0...n).each do |i|
    (0...n).each do |j|
      minor = matrix_minor(matrix, i, j)
      cofactor_mat[i][j] = ((-1) ** (i + j)) * determinant(minor)
    end
  end
  
  cofactor_mat
end

def adjugate_matrix(matrix)
  return nil if matrix.empty? || matrix.length != matrix[0].length
  
  cofactor_mat = cofactor_matrix(matrix)
  return nil if cofactor_mat.nil?
  
  n = matrix.length
  adjugate = Array.new(n) { Array.new(n) }
  
  (0...n).each do |i|
    (0...n).each do |j|
      adjugate[i][j] = cofactor_mat[j][i]
    end
  end
  
  adjugate
end

def matrix_inverse(matrix)
  det = determinant(matrix)
  return nil if det == 0
  
  adj = adjugate_matrix(matrix)
  return nil if adj.nil?
  
  n = matrix.length
  inverse = Array.new(n) { Array.new(n) }
  
  (0...n).each do |i|
    (0...n).each do |j|
      inverse[i][j] = adj[i][j].to_f / det
    end
  end
  
  inverse
end

if __FILE__ == $0
  matrix1 = [[1, 2], [3, 4]]
  puts "2x2 Matrix:"
  matrix1.each { |row| puts row.inspect }
  puts "Determinant: #{determinant(matrix1)}"
  puts "Determinant (LU): #{determinant_lu(matrix1)}"
  
  matrix2 = [[6, 1, 1], [4, -2, 5], [2, 8, 7]]
  puts "\n3x3 Matrix:"
  matrix2.each { |row| puts row.inspect }
  puts "Determinant: #{determinant(matrix2)}"
  puts "Determinant (LU): #{determinant_lu(matrix2)}"
end