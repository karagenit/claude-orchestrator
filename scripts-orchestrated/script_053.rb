def graph_bfs(graph, start_node)
  return [] if graph.nil? || start_node.nil?
  
  visited = Set.new
  queue = [start_node]
  result = []
  
  visited.add(start_node)
  
  while !queue.empty?
    node = queue.shift
    result << node
    
    if graph[node]
      graph[node].each do |neighbor|
        unless visited.include?(neighbor)
          visited.add(neighbor)
          queue << neighbor
        end
      end
    end
  end
  
  result
end

def shortest_path_bfs(graph, start_node, end_node)
  return [] if graph.nil? || start_node.nil? || end_node.nil?
  
  visited = Set.new
  queue = [[start_node, [start_node]]]
  visited.add(start_node)
  
  while !queue.empty?
    node, path = queue.shift
    
    return path if node == end_node
    
    if graph[node]
      graph[node].each do |neighbor|
        unless visited.include?(neighbor)
          visited.add(neighbor)
          queue << [neighbor, path + [neighbor]]
        end
      end
    end
  end
  
  []
end

def graph_levels(graph, start_node)
  return {} if graph.nil? || start_node.nil?
  
  levels = { start_node => 0 }
  queue = [start_node]
  
  while !queue.empty?
    node = queue.shift
    current_level = levels[node]
    
    if graph[node]
      graph[node].each do |neighbor|
        unless levels.key?(neighbor)
          levels[neighbor] = current_level + 1
          queue << neighbor
        end
      end
    end
  end
  
  levels
end