def capitalize_words(str)
  return "" if str.nil? || str.empty?
  
  str.split.map(&:capitalize).join(' ')
end

def capitalize_words_custom(str, delimiters = [' ', '-', '_'])
  return "" if str.nil? || str.empty?
  
  result = str.dup
  
  delimiters.each do |delimiter|
    result = result.split(delimiter).map(&:capitalize).join(delimiter)
  end
  
  result
end

def capitalize_first_letter_only(str)
  return "" if str.nil? || str.empty?
  
  words = str.split
  words.map do |word|
    word.downcase.capitalize
  end.join(' ')
end

def capitalize_except_articles(str, articles = ['a', 'an', 'the', 'and', 'but', 'or', 'for', 'nor', 'on', 'at', 'to', 'from', 'by', 'of', 'in'])
  return "" if str.nil? || str.empty?
  
  words = str.downcase.split
  
  words.map.with_index do |word, index|
    if index == 0 || !articles.include?(word.downcase)
      word.capitalize
    else
      word
    end
  end.join(' ')
end

def smart_capitalize(str)
  return "" if str.nil? || str.empty?
  
  result = str.gsub(/\b\w/) { |match| match.upcase }
  result
end

if __FILE__ == $0
  test_strings = [
    "hello world",
    "the quick brown fox",
    "ruby-on-rails programming",
    "hello_world_example",
    "the lord of the rings",
    "programming in ruby and python"
  ]
  
  test_strings.each do |str|
    puts "Original: '#{str}'"
    puts "Capitalized: '#{capitalize_words(str)}'"
    puts "Custom delimiters: '#{capitalize_words_custom(str)}'"
    puts "Except articles: '#{capitalize_except_articles(str)}'"
    puts "Smart capitalize: '#{smart_capitalize(str)}'"
    puts "---"
  end
end