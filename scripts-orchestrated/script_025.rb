def word_count(text)
  return {} if text.nil? || text.empty?
  
  words = text.downcase.scan(/\b\w+\b/)
  word_freq = Hash.new(0)
  
  words.each { |word| word_freq[word] += 1 }
  
  word_freq
end

def word_count_with_stats(text)
  return { words: {}, total_words: 0, unique_words: 0 } if text.nil? || text.empty?
  
  words = text.downcase.scan(/\b\w+\b/)
  word_freq = Hash.new(0)
  
  words.each { |word| word_freq[word] += 1 }
  
  {
    words: word_freq,
    total_words: words.length,
    unique_words: word_freq.keys.length,
    most_common: word_freq.max_by { |word, count| count },
    least_common: word_freq.min_by { |word, count| count }
  }
end

def word_count_sorted(text, sort_by = :frequency)
  word_freq = word_count(text)
  
  case sort_by
  when :frequency
    word_freq.sort_by { |word, count| -count }
  when :alphabetical
    word_freq.sort_by { |word, count| word }
  when :length
    word_freq.sort_by { |word, count| [-word.length, word] }
  else
    word_freq.to_a
  end
end

def filter_words_by_length(word_freq, min_length = 1, max_length = Float::INFINITY)
  filtered = {}
  
  word_freq.each do |word, count|
    if word.length >= min_length && word.length <= max_length
      filtered[word] = count
    end
  end
  
  filtered
end

if __FILE__ == $0
  sample_text = "The quick brown fox jumps over the lazy dog. The dog was really lazy, and the fox was very quick."
  
  puts "Text: #{sample_text}"
  puts
  
  word_freq = word_count(sample_text)
  puts "Word frequencies:"
  word_freq.each { |word, count| puts "  #{word}: #{count}" }
  
  puts
  stats = word_count_with_stats(sample_text)
  puts "Statistics:"
  puts "  Total words: #{stats[:total_words]}"
  puts "  Unique words: #{stats[:unique_words]}"
  puts "  Most common: #{stats[:most_common][0]} (#{stats[:most_common][1]} times)"
  puts "  Least common: #{stats[:least_common][0]} (#{stats[:least_common][1]} times)"
  
  puts
  puts "Sorted by frequency:"
  word_count_sorted(sample_text, :frequency).each do |word, count|
    puts "  #{word}: #{count}"
  end
end