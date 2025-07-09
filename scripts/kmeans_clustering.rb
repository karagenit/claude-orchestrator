def kmeans_clustering(points, k, max_iterations = 100)
  return [] if points.empty? || k <= 0
  
  centroids = points.sample(k)
  
  max_iterations.times do
    clusters = Array.new(k) { [] }
    
    points.each do |point|
      closest_centroid = 0
      min_distance = distance(point, centroids[0])
      
      (1...k).each do |i|
        dist = distance(point, centroids[i])
        if dist < min_distance
          min_distance = dist
          closest_centroid = i
        end
      end
      
      clusters[closest_centroid] << point
    end
    
    new_centroids = clusters.map do |cluster|
      next centroids[clusters.index(cluster)] if cluster.empty?
      
      avg_x = cluster.map { |p| p[0] }.sum / cluster.length.to_f
      avg_y = cluster.map { |p| p[1] }.sum / cluster.length.to_f
      [avg_x, avg_y]
    end
    
    break if new_centroids == centroids
    centroids = new_centroids
  end
  
  centroids
end

def distance(p1, p2)
  Math.sqrt((p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2)
end