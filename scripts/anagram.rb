def are_anagrams(str1, str2)
  clean1 = str1.downcase.gsub(/[^a-z]/, '')
  clean2 = str2.downcase.gsub(/[^a-z]/, '')
  
  return false if clean1.length != clean2.length
  
  char_count = Hash.new(0)
  
  clean1.each_char { |char| char_count[char] += 1 }
  clean2.each_char { |char| char_count[char] -= 1 }
  
  char_count.values.all? { |count| count == 0 }
end