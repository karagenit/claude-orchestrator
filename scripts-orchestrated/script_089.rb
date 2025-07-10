def traveling_salesman(distances)
  n = distances.length
  return nil if n < 2
  
  min_cost = Float::INFINITY
  best_path = nil
  
  def calculate_path_cost(path, distances)
    cost = 0
    (0...path.length - 1).each do |i|
      cost += distances[path[i]][path[i + 1]]
    end
    cost += distances[path.last][path.first]
    cost
  end
  
  cities = (1...n).to_a
  
  def permute(arr, start, distances, min_cost, best_path)
    if start == arr.length
      path = [0] + arr
      cost = calculate_path_cost(path, distances)
      if cost < min_cost[0]
        min_cost[0] = cost
        best_path[0] = path.dup
      end
      return
    end
    
    (start...arr.length).each do |i|
      arr[start], arr[i] = arr[i], arr[start]
      permute(arr, start + 1, distances, min_cost, best_path)
      arr[start], arr[i] = arr[i], arr[start]
    end
  end
  
  min_cost_ref = [min_cost]
  best_path_ref = [best_path]
  
  permute(cities, 0, distances, min_cost_ref, best_path_ref)
  
  {
    path: best_path_ref[0],
    cost: min_cost_ref[0]
  }
end

def demo_traveling_salesman
  distances = [
    [0, 10, 15, 20],
    [10, 0, 35, 25],
    [15, 35, 0, 30],
    [20, 25, 30, 0]
  ]
  
  puts "Distance matrix:"
  distances.each_with_index do |row, i|
    puts "#{i}: #{row.join(' ')}"
  end
  
  result = traveling_salesman(distances)
  
  if result
    puts "\nTraveling Salesman Solution:"
    puts "Path: #{result[:path].join(' -> ')} -> #{result[:path][0]}"
    puts "Total cost: #{result[:cost]}"
  else
    puts "\nNo solution found"
  end
  
  result
end