def count_vowels(str)
  return 0 if str.nil? || str.empty?
  
  vowels = "aeiouAEIOU"
  count = 0
  
  str.each_char do |char|
    count += 1 if vowels.include?(char)
  end
  
  count
end