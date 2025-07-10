def maze_solver(maze, start_pos, end_pos)
  return false if maze.nil? || maze.empty? || start_pos.nil? || end_pos.nil?
  
  rows = maze.size
  cols = maze[0].size
  visited = Array.new(rows) { Array.new(cols, false) }
  path = []
  
  return dfs_solve(maze, start_pos[0], start_pos[1], end_pos[0], end_pos[1], visited, path)
end

def dfs_solve(maze, x, y, end_x, end_y, visited, path)
  return false if x < 0 || x >= maze.size || y < 0 || y >= maze[0].size
  return false if maze[x][y] == 1 || visited[x][y]
  
  visited[x][y] = true
  path << [x, y]
  
  if x == end_x && y == end_y
    return path
  end
  
  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  
  directions.each do |dx, dy|
    new_x, new_y = x + dx, y + dy
    result = dfs_solve(maze, new_x, new_y, end_x, end_y, visited, path)
    return result if result
  end
  
  path.pop
  false
end