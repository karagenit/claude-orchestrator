def levenshtein_distance(str1, str2)
  return str2.length if str1.empty?
  return str1.length if str2.empty?
  
  len1 = str1.length
  len2 = str2.length
  
  matrix = Array.new(len1 + 1) { Array.new(len2 + 1, 0) }
  
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

def levenshtein_distance_with_operations(str1, str2)
  return { distance: str2.length, operations: str2.chars.map { |c| [:insert, c] } } if str1.empty?
  return { distance: str1.length, operations: str1.chars.map { |c| [:delete, c] } } if str2.empty?
  
  len1 = str1.length
  len2 = str2.length
  
  matrix = Array.new(len1 + 1) { Array.new(len2 + 1, 0) }
  
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
  
  { distance: matrix[len1][len2], matrix: matrix }
end

if __FILE__ == $0
  word1 = "kitten"
  word2 = "sitting"
  
  puts "Distance between '#{word1}' and '#{word2}': #{levenshtein_distance(word1, word2)}"
  
  test_cases = [
    ["cat", "bat"],
    ["saturday", "sunday"],
    ["", "hello"],
    ["world", ""],
    ["same", "same"]
  ]
  
  test_cases.each do |w1, w2|
    distance = levenshtein_distance(w1, w2)
    puts "Distance between '#{w1}' and '#{w2}': #{distance}"
  end
end