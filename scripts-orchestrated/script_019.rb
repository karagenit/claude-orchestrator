def string_contains(str, substring)
  return false if str.nil? || substring.nil?
  return true if substring.empty?
  
  str.include?(substring)
end

def string_contains_case_insensitive(str, substring)
  return false if str.nil? || substring.nil?
  return true if substring.empty?
  
  str.downcase.include?(substring.downcase)
end

def string_contains_regex(str, pattern)
  return false if str.nil? || pattern.nil?
  
  if pattern.is_a?(Regexp)
    !!(str =~ pattern)
  else
    !!(str =~ /#{Regexp.escape(pattern)}/)
  end
end

def string_contains_word(str, word)
  return false if str.nil? || word.nil?
  return true if word.empty?
  
  word_regex = /\b#{Regexp.escape(word)}\b/i
  !!(str =~ word_regex)
end

def string_contains_multiple(str, substrings)
  return [] if str.nil? || substrings.nil? || substrings.empty?
  
  results = {}
  substrings.each do |substring|
    results[substring] = string_contains(str, substring)
  end
  results
end

def string_contains_with_position(str, substring)
  return { found: false, positions: [] } if str.nil? || substring.nil?
  return { found: true, positions: [0] } if substring.empty?
  
  positions = []
  start_pos = 0
  
  while (pos = str.index(substring, start_pos))
    positions << pos
    start_pos = pos + 1
  end
  
  { found: !positions.empty?, positions: positions }
end

def string_contains_count(str, substring)
  return 0 if str.nil? || substring.nil? || substring.empty?
  
  count = 0
  start_pos = 0
  
  while (pos = str.index(substring, start_pos))
    count += 1
    start_pos = pos + 1
  end
  
  count
end

if __FILE__ == $0
  test_string = "The quick brown fox jumps over the lazy dog"
  test_cases = [
    "quick",
    "QUICK",
    "fox",
    "cat",
    "the",
    "jump",
    ""
  ]
  
  puts "Test string: '#{test_string}'"
  puts "---"
  
  test_cases.each do |substring|
    puts "Substring: '#{substring}'"
    puts "Contains: #{string_contains(test_string, substring)}"
    puts "Case insensitive: #{string_contains_case_insensitive(test_string, substring)}"
    puts "Word boundary: #{string_contains_word(test_string, substring)}"
    puts "With positions: #{string_contains_with_position(test_string, substring)}"
    puts "Count: #{string_contains_count(test_string, substring)}"
    puts "---"
  end
  
  puts "Multiple substrings test:"
  multiple_test = ["quick", "fox", "cat", "the"]
  puts "Results: #{string_contains_multiple(test_string, multiple_test)}"
end