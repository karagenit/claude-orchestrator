def lcs_length(str1, str2)
  return 0 if str1.nil? || str2.nil? || str1.empty? || str2.empty?
  
  m, n = str1.length, str2.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  
  (1..m).each do |i|
    (1..n).each do |j|
      if str1[i - 1] == str2[j - 1]
        dp[i][j] = dp[i - 1][j - 1] + 1
      else
        dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].max
      end
    end
  end
  
  dp[m][n]
end

def lcs_string(str1, str2)
  return "" if str1.nil? || str2.nil? || str1.empty? || str2.empty?
  
  m, n = str1.length, str2.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  
  (1..m).each do |i|
    (1..n).each do |j|
      if str1[i - 1] == str2[j - 1]
        dp[i][j] = dp[i - 1][j - 1] + 1
      else
        dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].max
      end
    end
  end
  
  lcs = ""
  i, j = m, n
  
  while i > 0 && j > 0
    if str1[i - 1] == str2[j - 1]
      lcs = str1[i - 1] + lcs
      i -= 1
      j -= 1
    elsif dp[i - 1][j] > dp[i][j - 1]
      i -= 1
    else
      j -= 1
    end
  end
  
  lcs
end

def lcs_all_strings(str1, str2)
  return [] if str1.nil? || str2.nil? || str1.empty? || str2.empty?
  
  length = lcs_length(str1, str2)
  return [""] if length == 0
  
  result = Set.new
  backtrack_lcs(str1, str2, str1.length, str2.length, "", result)
  result.to_a
end

def backtrack_lcs(str1, str2, i, j, current_lcs, result)
  if i == 0 || j == 0
    result.add(current_lcs.reverse)
    return
  end
  
  if str1[i - 1] == str2[j - 1]
    backtrack_lcs(str1, str2, i - 1, j - 1, current_lcs + str1[i - 1], result)
  else
    backtrack_lcs(str1, str2, i - 1, j, current_lcs, result) if lcs_length(str1[0...i-1], str2[0...j]) == current_lcs.length
    backtrack_lcs(str1, str2, i, j - 1, current_lcs, result) if lcs_length(str1[0...i], str2[0...j-1]) == current_lcs.length
  end
end