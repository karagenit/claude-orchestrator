def knapsack_01(capacity, weights, values)
  return 0 if capacity <= 0 || weights.empty? || values.empty?
  return 0 if weights.size != values.size
  
  n = weights.size
  dp = Array.new(n + 1) { Array.new(capacity + 1, 0) }
  
  (1..n).each do |i|
    (1..capacity).each do |w|
      if weights[i - 1] <= w
        include_item = values[i - 1] + dp[i - 1][w - weights[i - 1]]
        exclude_item = dp[i - 1][w]
        dp[i][w] = [include_item, exclude_item].max
      else
        dp[i][w] = dp[i - 1][w]
      end
    end
  end
  
  dp[n][capacity]
end

def knapsack_01_with_items(capacity, weights, values)
  return { max_value: 0, selected_items: [] } if capacity <= 0 || weights.empty?
  
  n = weights.size
  dp = Array.new(n + 1) { Array.new(capacity + 1, 0) }
  
  (1..n).each do |i|
    (1..capacity).each do |w|
      if weights[i - 1] <= w
        include_item = values[i - 1] + dp[i - 1][w - weights[i - 1]]
        exclude_item = dp[i - 1][w]
        dp[i][w] = [include_item, exclude_item].max
      else
        dp[i][w] = dp[i - 1][w]
      end
    end
  end
  
  selected_items = []
  w = capacity
  (n).downto(1) do |i|
    if dp[i][w] != dp[i - 1][w]
      selected_items << i - 1
      w -= weights[i - 1]
    end
  end
  
  {
    max_value: dp[n][capacity],
    selected_items: selected_items.reverse
  }
end