def word_ladder(start_word, end_word, word_list)
  return [] if start_word.nil? || end_word.nil? || word_list.nil?
  return [] if start_word.length != end_word.length
  return [start_word] if start_word == end_word
  
  word_set = word_list.to_set
  return [] unless word_set.include?(end_word)
  
  queue = [[start_word, [start_word]]]
  visited = Set.new([start_word])
  
  while !queue.empty?
    current_word, path = queue.shift
    
    neighbors = get_neighbors(current_word, word_set)
    
    neighbors.each do |neighbor|
      next if visited.include?(neighbor)
      
      new_path = path + [neighbor]
      
      if neighbor == end_word
        return new_path
      end
      
      visited.add(neighbor)
      queue.push([neighbor, new_path])
    end
  end
  
  []
end

def get_neighbors(word, word_set)
  neighbors = []
  
  (0...word.length).each do |i|
    ('a'..'z').each do |c|
      next if c == word[i]
      
      new_word = word.dup
      new_word[i] = c
      
      if word_set.include?(new_word)
        neighbors << new_word
      end
    end
  end
  
  neighbors
end