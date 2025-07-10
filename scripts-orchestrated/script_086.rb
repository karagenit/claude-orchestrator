def minimum_spanning_tree(edges, vertices)
  edges.sort_by! { |edge| edge[2] }
  
  parent = {}
  rank = {}
  
  vertices.each do |vertex|
    parent[vertex] = vertex
    rank[vertex] = 0
  end
  
  def find(parent, vertex)
    if parent[vertex] != vertex
      parent[vertex] = find(parent, parent[vertex])
    end
    parent[vertex]
  end
  
  def union(parent, rank, x, y)
    root_x = find(parent, x)
    root_y = find(parent, y)
    
    return false if root_x == root_y
    
    if rank[root_x] < rank[root_y]
      parent[root_x] = root_y
    elsif rank[root_x] > rank[root_y]
      parent[root_y] = root_x
    else
      parent[root_y] = root_x
      rank[root_x] += 1
    end
    
    true
  end
  
  mst = []
  total_weight = 0
  
  edges.each do |edge|
    u, v, weight = edge
    
    if union(parent, rank, u, v)
      mst << edge
      total_weight += weight
      break if mst.length == vertices.length - 1
    end
  end
  
  { edges: mst, total_weight: total_weight }
end

def demo_minimum_spanning_tree
  edges = [
    ['A', 'B', 4],
    ['A', 'H', 8],
    ['B', 'C', 8],
    ['B', 'H', 11],
    ['C', 'D', 7],
    ['C', 'F', 4],
    ['C', 'I', 2],
    ['D', 'E', 9],
    ['D', 'F', 14],
    ['E', 'F', 10],
    ['F', 'G', 2],
    ['G', 'H', 1],
    ['G', 'I', 6],
    ['H', 'I', 7]
  ]
  
  vertices = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']
  
  puts "Original edges:"
  edges.each do |u, v, weight|
    puts "#{u} - #{v}: #{weight}"
  end
  
  result = minimum_spanning_tree(edges, vertices)
  
  puts "\nMinimum Spanning Tree:"
  result[:edges].each do |u, v, weight|
    puts "#{u} - #{v}: #{weight}"
  end
  
  puts "\nTotal weight: #{result[:total_weight]}"
  
  result
end