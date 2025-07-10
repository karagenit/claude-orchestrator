def shortest_path(graph, start, target)
  distances = { start => 0 }
  previous = {}
  unvisited = graph.keys.to_set
  
  while !unvisited.empty?
    current = unvisited.min_by { |node| distances[node] || Float::INFINITY }
    
    if distances[current].nil? || distances[current] == Float::INFINITY
      break
    end
    
    unvisited.delete(current)
    
    if current == target
      path = []
      while current
        path.unshift(current)
        current = previous[current]
      end
      return { path: path, distance: distances[target] }
    end
    
    if graph[current]
      graph[current].each do |neighbor, weight|
        next unless unvisited.include?(neighbor)
        
        alt = distances[current] + weight
        if distances[neighbor].nil? || alt < distances[neighbor]
          distances[neighbor] = alt
          previous[neighbor] = current
        end
      end
    end
  end
  
  { path: nil, distance: Float::INFINITY }
end

def demo_shortest_path
  graph = {
    'A' => { 'B' => 4, 'C' => 2 },
    'B' => { 'C' => 1, 'D' => 5 },
    'C' => { 'D' => 8, 'E' => 10 },
    'D' => { 'E' => 2, 'F' => 6 },
    'E' => { 'F' => 3 },
    'F' => {}
  }
  
  puts "Graph:"
  graph.each do |node, neighbors|
    neighbors.each do |neighbor, weight|
      puts "#{node} -> #{neighbor}: #{weight}"
    end
  end
  
  result = shortest_path(graph, 'A', 'F')
  
  if result[:path]
    puts "\nShortest path from A to F:"
    puts "Path: #{result[:path].join(' -> ')}"
    puts "Distance: #{result[:distance]}"
  else
    puts "\nNo path found from A to F"
  end
  
  result = shortest_path(graph, 'A', 'E')
  if result[:path]
    puts "\nShortest path from A to E:"
    puts "Path: #{result[:path].join(' -> ')}"
    puts "Distance: #{result[:distance]}"
  end
  
  result
end