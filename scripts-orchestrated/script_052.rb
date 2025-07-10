def graph_dfs(graph, start_node, visited = Set.new)
  return [] if graph.nil? || start_node.nil?
  
  visited.add(start_node)
  result = [start_node]
  
  if graph[start_node]
    graph[start_node].each do |neighbor|
      unless visited.include?(neighbor)
        result.concat(graph_dfs(graph, neighbor, visited))
      end
    end
  end
  
  result
end

def graph_dfs_iterative(graph, start_node)
  return [] if graph.nil? || start_node.nil?
  
  visited = Set.new
  stack = [start_node]
  result = []
  
  while !stack.empty?
    node = stack.pop
    
    unless visited.include?(node)
      visited.add(node)
      result << node
      
      if graph[node]
        graph[node].reverse_each do |neighbor|
          stack.push(neighbor) unless visited.include?(neighbor)
        end
      end
    end
  end
  
  result
end

def connected_components(graph)
  visited = Set.new
  components = []
  
  graph.keys.each do |node|
    unless visited.include?(node)
      component = graph_dfs(graph, node, visited)
      components << component
    end
  end
  
  components
end