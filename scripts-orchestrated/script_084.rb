def topological_sort(graph)
  in_degree = Hash.new(0)
  
  graph.each do |node, neighbors|
    in_degree[node] = 0 unless in_degree.key?(node)
    neighbors.each do |neighbor|
      in_degree[neighbor] += 1
    end
  end
  
  queue = []
  in_degree.each do |node, degree|
    queue << node if degree == 0
  end
  
  result = []
  
  while !queue.empty?
    current = queue.shift
    result << current
    
    if graph[current]
      graph[current].each do |neighbor|
        in_degree[neighbor] -= 1
        queue << neighbor if in_degree[neighbor] == 0
      end
    end
  end
  
  if result.length != in_degree.length
    puts "Graph has a cycle - topological sort not possible"
    return nil
  end
  
  result
end

def demo_topological_sort
  graph = {
    'A' => ['B', 'C'],
    'B' => ['D'],
    'C' => ['D'],
    'D' => ['E'],
    'E' => []
  }
  
  puts "Graph:"
  graph.each do |node, neighbors|
    puts "#{node} -> #{neighbors.join(', ')}"
  end
  
  sorted = topological_sort(graph)
  puts "\nTopological sort: #{sorted.join(' -> ')}"
  
  cyclic_graph = {
    'A' => ['B'],
    'B' => ['C'],
    'C' => ['A']
  }
  
  puts "\nTesting cyclic graph:"
  topological_sort(cyclic_graph)
  
  sorted
end