def sudoku_solver(board)
  return false if board.nil? || board.size != 9
  
  (0...9).each do |row|
    (0...9).each do |col|
      if board[row][col] == 0
        (1..9).each do |num|
          if is_valid_move?(board, row, col, num)
            board[row][col] = num
            return true if sudoku_solver(board)
            board[row][col] = 0
          end
        end
        return false
      end
    end
  end
  
  true
end

def is_valid_move?(board, row, col, num)
  (0...9).each do |i|
    return false if board[row][i] == num
    return false if board[i][col] == num
  end
  
  start_row = (row / 3) * 3
  start_col = (col / 3) * 3
  
  (0...3).each do |i|
    (0...3).each do |j|
      return false if board[start_row + i][start_col + j] == num
    end
  end
  
  true
end