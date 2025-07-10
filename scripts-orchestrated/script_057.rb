def edit_distance(str1, str2)
  return str2.length if str1.nil? || str1.empty?
  return str1.length if str2.nil? || str2.empty?
  
  m, n = str1.length, str2.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  
  (0..m).each { |i| dp[i][0] = i }
  (0..n).each { |j| dp[0][j] = j }
  
  (1..m).each do |i|
    (1..n).each do |j|
      if str1[i - 1] == str2[j - 1]
        dp[i][j] = dp[i - 1][j - 1]
      else
        dp[i][j] = [
          dp[i - 1][j] + 1,      # deletion
          dp[i][j - 1] + 1,      # insertion
          dp[i - 1][j - 1] + 1   # substitution
        ].min
      end
    end
  end
  
  dp[m][n]
end

def edit_distance_with_operations(str1, str2)
  return { distance: str2.length, operations: str2.chars.map.with_index { |c, i| [:insert, i, c] } } if str1.nil? || str1.empty?
  return { distance: str1.length, operations: (0...str1.length).map { |i| [:delete, i] } } if str2.nil? || str2.empty?
  
  m, n = str1.length, str2.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  
  (0..m).each { |i| dp[i][0] = i }
  (0..n).each { |j| dp[0][j] = j }
  
  (1..m).each do |i|
    (1..n).each do |j|
      if str1[i - 1] == str2[j - 1]
        dp[i][j] = dp[i - 1][j - 1]
      else
        dp[i][j] = [
          dp[i - 1][j] + 1,      # deletion
          dp[i][j - 1] + 1,      # insertion
          dp[i - 1][j - 1] + 1   # substitution
        ].min
      end
    end
  end
  
  operations = []
  i, j = m, n
  
  while i > 0 || j > 0
    if i > 0 && j > 0 && str1[i - 1] == str2[j - 1]
      i -= 1
      j -= 1
    elsif i > 0 && j > 0 && dp[i][j] == dp[i - 1][j - 1] + 1
      operations.unshift([:substitute, i - 1, str2[j - 1]])
      i -= 1
      j -= 1
    elsif i > 0 && dp[i][j] == dp[i - 1][j] + 1
      operations.unshift([:delete, i - 1])
      i -= 1
    else
      operations.unshift([:insert, i, str2[j - 1]])
      j -= 1
    end
  end
  
  { distance: dp[m][n], operations: operations }
end