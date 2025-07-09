def levenshtein_distance(str1, str2)
  len1 = str1.length
  len2 = str2.length
  
  matrix = Array.new(len1 + 1) { Array.new(len2 + 1) }
  
  (0..len1).each { |i| matrix[i][0] = i }
  (0..len2).each { |j| matrix[0][j] = j }
  
  (1..len1).each do |i|
    (1..len2).each do |j|
      cost = str1[i - 1] == str2[j - 1] ? 0 : 1
      
      matrix[i][j] = [
        matrix[i - 1][j] + 1,
        matrix[i][j - 1] + 1,
        matrix[i - 1][j - 1] + cost
      ].min
    end
  end
  
  matrix[len1][len2]
end