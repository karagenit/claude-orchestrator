def count_consonants(str)
  return 0 if str.nil? || str.empty?
  
  vowels = "aeiouAEIOU"
  count = 0
  
  str.each_char do |char|
    if char.match(/[a-zA-Z]/) && !vowels.include?(char)
      count += 1
    end
  end
  
  count
end