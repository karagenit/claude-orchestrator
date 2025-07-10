def dijkstra_simple(graph, start_node)
  return {} if graph.nil? || start_node.nil?
  
  distances = {}
  visited = Set.new
  previous = {}
  
  graph.keys.each do |node|
    distances[node] = Float::INFINITY
  end
  distances[start_node] = 0
  
  while visited.size < graph.keys.size
    current = nil
    min_distance = Float::INFINITY
    
    distances.each do |node, distance|
      if !visited.include?(node) && distance < min_distance
        min_distance = distance
        current = node
      end
    end
    
    break if current.nil?
    
    visited.add(current)
    
    if graph[current]
      graph[current].each do |neighbor, weight|
        next if visited.include?(neighbor)
        
        alt_distance = distances[current] + weight
        if alt_distance < distances[neighbor]
          distances[neighbor] = alt_distance
          previous[neighbor] = current
        end
      end
    end
  end
  
  {
    distances: distances,
    previous: previous
  }
end

def shortest_path_dijkstra(graph, start_node, end_node)
  result = dijkstra_simple(graph, start_node)
  distances = result[:distances]
  previous = result[:previous]
  
  return [] if distances[end_node] == Float::INFINITY
  
  path = []
  current = end_node
  
  while current
    path.unshift(current)
    current = previous[current]
  end
  
  path
end