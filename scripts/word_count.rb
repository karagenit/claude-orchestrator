def word_count(text)
  return 0 if text.nil? || text.empty?
  
  words = text.strip.split(/\s+/)
  words.reject(&:empty?).length
end