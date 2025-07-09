def capitalize_words(text)
  return "" if text.nil? || text.empty?
  
  words = text.split(/(\s+)/)
  
  words.map do |word|
    if word.match(/^\s+$/)
      word
    else
      word.capitalize
    end
  end.join
end