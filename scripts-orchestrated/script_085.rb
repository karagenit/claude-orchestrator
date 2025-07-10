def strongly_connected(graph)
  visited = {}
  finish_order = []
  
  def dfs1(node, graph, visited, finish_order)
    visited[node] = true
    
    if graph[node]
      graph[node].each do |neighbor|
        unless visited[neighbor]
          dfs1(neighbor, graph, visited, finish_order)
        end
      end
    end
    
    finish_order << node
  end
  
  graph.each_key do |node|
    unless visited[node]
      dfs1(node, graph, visited, finish_order)
    end
  end
  
  transpose_graph = {}
  graph.each do |node, neighbors|
    transpose_graph[node] = []
    neighbors.each do |neighbor|
      transpose_graph[neighbor] ||= []
      transpose_graph[neighbor] << node
    end
  end
  
  visited = {}
  components = []
  
  def dfs2(node, transpose_graph, visited, component)
    visited[node] = true
    component << node
    
    if transpose_graph[node]
      transpose_graph[node].each do |neighbor|
        unless visited[neighbor]
          dfs2(neighbor, transpose_graph, visited, component)
        end
      end
    end
  end
  
  finish_order.reverse.each do |node|
    unless visited[node]
      component = []
      dfs2(node, transpose_graph, visited, component)
      components << component
    end
  end
  
  components
end

def demo_strongly_connected
  graph = {
    'A' => ['B'],
    'B' => ['C', 'E'],
    'C' => ['D'],
    'D' => ['C'],
    'E' => ['A', 'F'],
    'F' => ['G'],
    'G' => ['F']
  }
  
  puts "Graph:"
  graph.each do |node, neighbors|
    puts "#{node} -> #{neighbors.join(', ')}"
  end
  
  components = strongly_connected(graph)
  puts "\nStrongly connected components:"
  components.each_with_index do |component, index|
    puts "Component #{index + 1}: #{component.join(', ')}"
  end
  
  components
end