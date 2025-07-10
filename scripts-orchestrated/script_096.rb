def boggle_solver(board, dictionary)
  return [] if board.nil? || board.empty? || dictionary.nil?
  
  rows = board.size
  cols = board[0].size
  found_words = Set.new
  dict_set = dictionary.to_set
  
  (0...rows).each do |i|
    (0...cols).each do |j|
      visited = Array.new(rows) { Array.new(cols, false) }
      dfs_boggle(board, i, j, '', visited, dict_set, found_words)
    end
  end
  
  found_words.to_a.sort
end

def dfs_boggle(board, row, col, current_word, visited, dict_set, found_words)
  return if row < 0 || row >= board.size || col < 0 || col >= board[0].size
  return if visited[row][col]
  
  visited[row][col] = true
  current_word += board[row][col].downcase
  
  if current_word.length >= 3 && dict_set.include?(current_word)
    found_words.add(current_word)
  end
  
  return if current_word.length >= 16
  
  directions = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1],           [0, 1],
    [1, -1],  [1, 0],  [1, 1]
  ]
  
  directions.each do |dx, dy|
    new_row = row + dx
    new_col = col + dy
    dfs_boggle(board, new_row, new_col, current_word, visited, dict_set, found_words)
  end
  
  visited[row][col] = false
end