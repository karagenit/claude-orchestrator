def palindrome_check(str)
  return false if str.nil?
  
  cleaned = str.downcase.gsub(/[^a-z0-9]/, '')
  
  cleaned == cleaned.reverse
end

def palindrome_check_two_pointers(str)
  return false if str.nil?
  
  cleaned = str.downcase.gsub(/[^a-z0-9]/, '')
  left = 0
  right = cleaned.length - 1
  
  while left < right
    return false if cleaned[left] != cleaned[right]
    left += 1
    right -= 1
  end
  
  true
end

def palindrome_check_recursive(str)
  return false if str.nil?
  
  cleaned = str.downcase.gsub(/[^a-z0-9]/, '')
  
  check_palindrome_recursive(cleaned, 0, cleaned.length - 1)
end

def check_palindrome_recursive(str, left, right)
  return true if left >= right
  
  return false if str[left] != str[right]
  
  check_palindrome_recursive(str, left + 1, right - 1)
end

def longest_palindrome_substring(str)
  return "" if str.nil? || str.empty?
  
  longest = ""
  
  str.length.times do |i|
    odd_palindrome = expand_around_center(str, i, i)
    even_palindrome = expand_around_center(str, i, i + 1)
    
    current_longest = odd_palindrome.length > even_palindrome.length ? odd_palindrome : even_palindrome
    longest = current_longest if current_longest.length > longest.length
  end
  
  longest
end

def expand_around_center(str, left, right)
  while left >= 0 && right < str.length && str[left] == str[right]
    left -= 1
    right += 1
  end
  
  str[left + 1..right - 1]
end

if __FILE__ == $0
  test_strings = [
    "racecar",
    "A man a plan a canal Panama",
    "race a car",
    "hello",
    "Madam",
    "Was it a car or a cat I saw?"
  ]
  
  puts "Palindrome checking:"
  test_strings.each do |str|
    puts "'#{str}' -> #{palindrome_check(str)}"
  end
  
  puts "\nLongest palindrome substrings:"
  ["babad", "cbbd", "racecar"].each do |str|
    puts "'#{str}' -> '#{longest_palindrome_substring(str)}'"
  end
end