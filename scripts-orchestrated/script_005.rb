class Graph
  def initialize
    @adjacency_list = {}
  end
  
  def add_vertex(vertex)
    @adjacency_list[vertex] ||= []
  end
  
  def add_edge(vertex1, vertex2)
    add_vertex(vertex1)
    add_vertex(vertex2)
    @adjacency_list[vertex1] << vertex2
    @adjacency_list[vertex2] << vertex1
  end
  
  def bfs(start_vertex)
    return [] unless @adjacency_list[start_vertex]
    
    queue = [start_vertex]
    visited = Set.new([start_vertex])
    result = []
    
    while !queue.empty?
      vertex = queue.shift
      result << vertex
      
      @adjacency_list[vertex].each do |neighbor|
        unless visited.include?(neighbor)
          visited.add(neighbor)
          queue << neighbor
        end
      end
    end
    
    result
  end
  
  def shortest_path(start_vertex, end_vertex)
    return [] unless @adjacency_list[start_vertex] && @adjacency_list[end_vertex]
    
    queue = [[start_vertex, [start_vertex]]]
    visited = Set.new([start_vertex])
    
    while !queue.empty?
      vertex, path = queue.shift
      
      return path if vertex == end_vertex
      
      @adjacency_list[vertex].each do |neighbor|
        unless visited.include?(neighbor)
          visited.add(neighbor)
          queue << [neighbor, path + [neighbor]]
        end
      end
    end
    
    []
  end
  
  def find_all_paths(start_vertex, end_vertex, path = [])
    path = path + [start_vertex]
    
    return [path] if start_vertex == end_vertex
    
    return [] unless @adjacency_list[start_vertex]
    
    paths = []
    @adjacency_list[start_vertex].each do |neighbor|
      unless path.include?(neighbor)
        new_paths = find_all_paths(neighbor, end_vertex, path)
        paths.concat(new_paths)
      end
    end
    
    paths
  end
  
  def level_order_traversal(start_vertex)
    return {} unless @adjacency_list[start_vertex]
    
    queue = [[start_vertex, 0]]
    visited = Set.new([start_vertex])
    levels = {}
    
    while !queue.empty?
      vertex, level = queue.shift
      levels[level] ||= []
      levels[level] << vertex
      
      @adjacency_list[vertex].each do |neighbor|
        unless visited.include?(neighbor)
          visited.add(neighbor)
          queue << [neighbor, level + 1]
        end
      end
    end
    
    levels
  end
end

if __FILE__ == $0
  require 'set'
  
  graph = Graph.new
  graph.add_edge('A', 'B')
  graph.add_edge('A', 'C')
  graph.add_edge('B', 'D')
  graph.add_edge('C', 'E')
  graph.add_edge('D', 'E')
  graph.add_edge('D', 'F')
  
  puts "BFS traversal from A: #{graph.bfs('A')}"
  puts "Shortest path from A to E: #{graph.shortest_path('A', 'E')}"
  puts "All paths from A to E: #{graph.find_all_paths('A', 'E')}"
  puts "Level order traversal from A: #{graph.level_order_traversal('A')}"
end