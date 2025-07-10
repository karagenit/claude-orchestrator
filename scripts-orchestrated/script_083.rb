class UnionFind
  def initialize(n)
    @parent = (0...n).to_a
    @rank = Array.new(n, 0)
    @components = n
  end

  def find(x)
    if @parent[x] != x
      @parent[x] = find(@parent[x])
    end
    @parent[x]
  end

  def union(x, y)
    root_x = find(x)
    root_y = find(y)
    
    return false if root_x == root_y
    
    if @rank[root_x] < @rank[root_y]
      @parent[root_x] = root_y
    elsif @rank[root_x] > @rank[root_y]
      @parent[root_y] = root_x
    else
      @parent[root_y] = root_x
      @rank[root_x] += 1
    end
    
    @components -= 1
    true
  end

  def connected?(x, y)
    find(x) == find(y)
  end

  def component_count
    @components
  end
end

def union_find
  uf = UnionFind.new(10)
  
  puts "Initial components: #{uf.component_count}"
  
  uf.union(0, 1)
  uf.union(2, 3)
  uf.union(4, 5)
  puts "After unions: #{uf.component_count}"
  
  puts "0 and 1 connected: #{uf.connected?(0, 1)}"
  puts "0 and 2 connected: #{uf.connected?(0, 2)}"
  
  uf.union(1, 2)
  puts "After connecting 1 and 2: #{uf.component_count}"
  puts "0 and 3 connected: #{uf.connected?(0, 3)}"
  
  uf
end