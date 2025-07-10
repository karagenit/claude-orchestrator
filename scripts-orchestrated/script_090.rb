def n_queens(n)
  solutions = []
  board = Array.new(n) { Array.new(n, 0) }
  
  def is_safe(board, row, col, n)
    (0...col).each do |i|
      return false if board[row][i] == 1
    end
    
    i, j = row, col
    while i >= 0 && j >= 0
      return false if board[i][j] == 1
      i -= 1
      j -= 1
    end
    
    i, j = row, col
    while i < n && j >= 0
      return false if board[i][j] == 1
      i += 1
      j -= 1
    end
    
    true
  end
  
  def solve_nqueens(board, col, n, solutions)
    if col >= n
      solution = []
      board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          if cell == 1
            solution << [i, j]
          end
        end
      end
      solutions << solution
      return true
    end
    
    (0...n).each do |i|
      if is_safe(board, i, col, n)
        board[i][col] = 1
        solve_nqueens(board, col + 1, n, solutions)
        board[i][col] = 0
      end
    end
    
    false
  end
  
  solve_nqueens(board, 0, n, solutions)
  solutions
end

def demo_n_queens
  n = 4
  puts "Solving #{n}-Queens problem:"
  
  solutions = n_queens(n)
  
  puts "Found #{solutions.length} solution(s):"
  
  solutions.each_with_index do |solution, index|
    puts "\nSolution #{index + 1}:"
    board = Array.new(n) { Array.new(n, '.') }
    
    solution.each do |row, col|
      board[row][col] = 'Q'
    end
    
    board.each do |row|
      puts row.join(' ')
    end
  end
  
  solutions
end