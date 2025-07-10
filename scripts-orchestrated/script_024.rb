def anagram_check(str1, str2)
  return false if str1.nil? || str2.nil?
  
  clean_str1 = str1.downcase.gsub(/[^a-z]/, '')
  clean_str2 = str2.downcase.gsub(/[^a-z]/, '')
  
  return false if clean_str1.length != clean_str2.length
  
  clean_str1.chars.sort == clean_str2.chars.sort
end

def anagram_check_with_frequency(str1, str2)
  return { anagram: false, reason: "One or both strings are nil" } if str1.nil? || str2.nil?
  
  clean_str1 = str1.downcase.gsub(/[^a-z]/, '')
  clean_str2 = str2.downcase.gsub(/[^a-z]/, '')
  
  return { anagram: false, reason: "Different lengths" } if clean_str1.length != clean_str2.length
  
  freq1 = Hash.new(0)
  freq2 = Hash.new(0)
  
  clean_str1.each_char { |c| freq1[c] += 1 }
  clean_str2.each_char { |c| freq2[c] += 1 }
  
  if freq1 == freq2
    { anagram: true, frequency_map: freq1 }
  else
    { anagram: false, reason: "Different character frequencies", freq1: freq1, freq2: freq2 }
  end
end

def find_anagrams(word, word_list)
  return [] if word.nil? || word_list.nil?
  
  anagrams = []
  
  word_list.each do |candidate|
    if anagram_check(word, candidate) && word.downcase != candidate.downcase
      anagrams << candidate
    end
  end
  
  anagrams
end

if __FILE__ == $0
  test_cases = [
    ["listen", "silent"],
    ["elbow", "below"],
    ["study", "dusty"],
    ["night", "thing"],
    ["hello", "world"],
    ["A gentleman", "Elegant man"],
    ["Conversation", "Voices rant on"]
  ]
  
  test_cases.each do |word1, word2|
    result = anagram_check(word1, word2)
    puts "'#{word1}' and '#{word2}' are #{result ? '' : 'not '}anagrams"
  end
  
  word_list = ["listen", "silent", "elbow", "below", "study", "dusty", "hello", "world"]
  target = "listen"
  anagrams = find_anagrams(target, word_list)
  puts "Anagrams of '#{target}': #{anagrams.join(', ')}"
end