def max_flow(graph, source, sink)
  max_flow_value = 0
  residual_graph = {}
  
  graph.each do |u, neighbors|
    residual_graph[u] = {}
    neighbors.each do |v, capacity|
      residual_graph[u][v] = capacity
      residual_graph[v] ||= {}
      residual_graph[v][u] ||= 0
    end
  end
  
  def bfs_find_path(residual_graph, source, sink, parent)
    visited = {}
    queue = [source]
    visited[source] = true
    
    while !queue.empty?
      u = queue.shift
      
      residual_graph[u].each do |v, capacity|
        if !visited[v] && capacity > 0
          visited[v] = true
          parent[v] = u
          return true if v == sink
          queue << v
        end
      end
    end
    
    false
  end
  
  parent = {}
  
  while bfs_find_path(residual_graph, source, sink, parent)
    path_flow = Float::INFINITY
    s = sink
    
    while s != source
      path_flow = [path_flow, residual_graph[parent[s]][s]].min
      s = parent[s]
    end
    
    max_flow_value += path_flow
    
    v = sink
    while v != source
      u = parent[v]
      residual_graph[u][v] -= path_flow
      residual_graph[v][u] += path_flow
      v = parent[v]
    end
    
    parent.clear
  end
  
  max_flow_value
end

def demo_max_flow
  graph = {
    'S' => { 'A' => 10, 'C' => 10 },
    'A' => { 'B' => 4, 'C' => 2, 'D' => 8 },
    'B' => { 'T' => 10 },
    'C' => { 'B' => 9, 'D' => 9 },
    'D' => { 'B' => 6, 'T' => 10 },
    'T' => {}
  }
  
  puts "Graph capacities:"
  graph.each do |node, neighbors|
    neighbors.each do |neighbor, capacity|
      puts "#{node} -> #{neighbor}: #{capacity}"
    end
  end
  
  flow = max_flow(graph, 'S', 'T')
  puts "\nMaximum flow from S to T: #{flow}"
  
  flow
end