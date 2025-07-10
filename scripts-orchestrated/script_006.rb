def reverse_string(str)
  return nil if str.nil?
  
  str.reverse
end

def reverse_string_iterative(str)
  return nil if str.nil?
  
  reversed = ""
  (str.length - 1).downto(0) do |i|
    reversed += str[i]
  end
  
  reversed
end

def reverse_string_recursive(str)
  return nil if str.nil?
  return str if str.length <= 1
  
  str[-1] + reverse_string_recursive(str[0...-1])
end

def reverse_string_two_pointers(str)
  return nil if str.nil?
  
  chars = str.chars
  left = 0
  right = chars.length - 1
  
  while left < right
    chars[left], chars[right] = chars[right], chars[left]
    left += 1
    right -= 1
  end
  
  chars.join
end

def reverse_words_in_string(str)
  return nil if str.nil?
  
  str.split.reverse.join(' ')
end

def reverse_words_preserve_spaces(str)
  return nil if str.nil?
  
  words = str.split(' ')
  reversed_words = words.reverse
  reversed_words.join(' ')
end

def reverse_each_word(str)
  return nil if str.nil?
  
  str.split.map(&:reverse).join(' ')
end

if __FILE__ == $0
  test_strings = [
    "hello",
    "world",
    "Ruby programming",
    "The quick brown fox",
    "a",
    "",
    "racecar"
  ]
  
  puts "String reversal methods:"
  test_strings.each do |str|
    puts "Original: '#{str}'"
    puts "  Built-in reverse: '#{reverse_string(str)}'"
    puts "  Iterative: '#{reverse_string_iterative(str)}'"
    puts "  Recursive: '#{reverse_string_recursive(str)}'"
    puts "  Two pointers: '#{reverse_string_two_pointers(str)}'"
    puts "  Reverse words: '#{reverse_words_in_string(str)}'"
    puts "  Reverse each word: '#{reverse_each_word(str)}'"
    puts
  end
end