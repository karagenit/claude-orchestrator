def count_vowels(str)
  return 0 if str.nil? || str.empty?
  
  vowels = 'aeiouAEIOU'
  count = 0
  
  str.each_char do |char|
    count += 1 if vowels.include?(char)
  end
  
  count
end

def count_vowels_detailed(str)
  return { total: 0, breakdown: {} } if str.nil? || str.empty?
  
  vowel_counts = { 'a' => 0, 'e' => 0, 'i' => 0, 'o' => 0, 'u' => 0 }
  total = 0
  
  str.downcase.each_char do |char|
    if vowel_counts.key?(char)
      vowel_counts[char] += 1
      total += 1
    end
  end
  
  { total: total, breakdown: vowel_counts }
end

def count_vowels_regex(str)
  return 0 if str.nil? || str.empty?
  
  matches = str.scan(/[aeiouAEIOU]/)
  matches.length
end

def vowel_percentage(str)
  return 0.0 if str.nil? || str.empty?
  
  total_chars = str.length
  vowel_count = count_vowels(str)
  
  (vowel_count.to_f / total_chars * 100).round(2)
end

if __FILE__ == $0
  test_strings = [
    "Hello World",
    "Programming is fun",
    "AEIOU",
    "bcdfg",
    "The quick brown fox jumps over the lazy dog"
  ]
  
  test_strings.each do |str|
    puts "String: '#{str}'"
    puts "Vowel count: #{count_vowels(str)}"
    puts "Detailed count: #{count_vowels_detailed(str)}"
    puts "Vowel percentage: #{vowel_percentage(str)}%"
    puts "---"
  end
end