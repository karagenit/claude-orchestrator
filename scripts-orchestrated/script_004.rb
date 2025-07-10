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
  
  def dfs(start_vertex, visited = Set.new)
    return [] unless @adjacency_list[start_vertex]
    
    visited.add(start_vertex)
    result = [start_vertex]
    
    @adjacency_list[start_vertex].each do |neighbor|
      unless visited.include?(neighbor)
        result.concat(dfs(neighbor, visited))
      end
    end
    
    result
  end
  
  def dfs_iterative(start_vertex)
    return [] unless @adjacency_list[start_vertex]
    
    stack = [start_vertex]
    visited = Set.new
    result = []
    
    while !stack.empty?
      vertex = stack.pop
      
      unless visited.include?(vertex)
        visited.add(vertex)
        result << vertex
        
        @adjacency_list[vertex].reverse_each do |neighbor|
          stack << neighbor unless visited.include?(neighbor)
        end
      end
    end
    
    result
  end
  
  def has_path?(start_vertex, end_vertex)
    return false unless @adjacency_list[start_vertex]
    return true if start_vertex == end_vertex
    
    visited = Set.new
    stack = [start_vertex]
    
    while !stack.empty?
      vertex = stack.pop
      
      unless visited.include?(vertex)
        visited.add(vertex)
        return true if vertex == end_vertex
        
        @adjacency_list[vertex].each do |neighbor|
          stack << neighbor unless visited.include?(neighbor)
        end
      end
    end
    
    false
  end
  
  def vertices
    @adjacency_list.keys
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
  
  puts "DFS traversal from A: #{graph.dfs('A')}"
  puts "DFS iterative from A: #{graph.dfs_iterative('A')}"
  puts "Has path from A to E: #{graph.has_path?('A', 'E')}"
  puts "Has path from A to Z: #{graph.has_path?('A', 'Z')}"
end