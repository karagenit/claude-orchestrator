def subset_sum(arr, target)
  return true if target == 0
  return false if arr.empty? || target < 0
  
  dp = Array.new(target + 1, false)
  dp[0] = true
  
  arr.each do |num|
    (target).downto(num) do |i|
      dp[i] = dp[i] || dp[i - num]
    end
  end
  
  dp[target]
end

def subset_sum_recursive(arr, target, index = 0)
  return true if target == 0
  return false if index >= arr.length || target < 0
  
  include_current = subset_sum_recursive(arr, target - arr[index], index + 1)
  exclude_current = subset_sum_recursive(arr, target, index + 1)
  
  include_current || exclude_current
end

def find_subset_sum(arr, target)
  return [] if target == 0
  return nil if arr.empty? || target < 0
  
  dp = Array.new(arr.length + 1) { Array.new(target + 1, false) }
  
  (0..arr.length).each { |i| dp[i][0] = true }
  
  (1..arr.length).each do |i|
    (1..target).each do |j|
      dp[i][j] = dp[i-1][j]
      if j >= arr[i-1]
        dp[i][j] = dp[i][j] || dp[i-1][j - arr[i-1]]
      end
    end
  end
  
  return nil unless dp[arr.length][target]
  
  result = []
  i, j = arr.length, target
  while i > 0 && j > 0
    if !dp[i-1][j]
      result << arr[i-1]
      j -= arr[i-1]
    end
    i -= 1
  end
  
  result
end

def count_subsets_with_sum(arr, target)
  return 1 if target == 0
  return 0 if arr.empty? || target < 0
  
  dp = Array.new(target + 1, 0)
  dp[0] = 1
  
  arr.each do |num|
    (target).downto(num) do |i|
      dp[i] += dp[i - num]
    end
  end
  
  dp[target]
end

if __FILE__ == $0
  arr = [3, 34, 4, 12, 5, 2]
  target = 9
  puts "Array: #{arr}"
  puts "Target: #{target}"
  puts "Subset sum exists: #{subset_sum(arr, target)}"
  puts "Subset found: #{find_subset_sum(arr, target)}"
  puts "Count of subsets: #{count_subsets_with_sum(arr, target)}"
end