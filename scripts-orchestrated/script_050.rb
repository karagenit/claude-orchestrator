def regex_match(text, pattern, options = {})
  return nil if text.nil? || pattern.nil?
  
  case_insensitive = options[:case_insensitive] || false
  multiline = options[:multiline] || false
  extended = options[:extended] || false
  global = options[:global] || false
  named_captures = options[:named_captures] || false
  
  flags = 0
  flags |= Regexp::IGNORECASE if case_insensitive
  flags |= Regexp::MULTILINE if multiline
  flags |= Regexp::EXTENDED if extended
  
  begin
    regex = case pattern
            when Regexp
              pattern
            when String
              Regexp.new(pattern, flags)
            else
              return nil
            end
  rescue RegexpError => e
    return { error: "Invalid regex pattern: #{e.message}" }
  end
  
  if global
    matches = []
    text.scan(regex) do |match|
      match_data = Regexp.last_match
      matches << build_match_result(match_data, named_captures)
    end
    return matches
  else
    match_data = regex.match(text)
    return nil unless match_data
    
    return build_match_result(match_data, named_captures)
  end
end

def build_match_result(match_data, include_named_captures)
  result = {
    match: match_data.to_s,
    captures: match_data.captures,
    offset: match_data.offset(0),
    pre_match: match_data.pre_match,
    post_match: match_data.post_match
  }
  
  if include_named_captures && match_data.names.any?
    result[:named_captures] = {}
    match_data.names.each do |name|
      result[:named_captures][name] = match_data[name]
    end
  end
  
  result
end

def regex_replace(text, pattern, replacement, options = {})
  return nil if text.nil? || pattern.nil?
  return text if replacement.nil?
  
  case_insensitive = options[:case_insensitive] || false
  multiline = options[:multiline] || false
  extended = options[:extended] || false
  global = options[:global] || true
  
  flags = 0
  flags |= Regexp::IGNORECASE if case_insensitive
  flags |= Regexp::MULTILINE if multiline
  flags |= Regexp::EXTENDED if extended
  
  begin
    regex = case pattern
            when Regexp
              pattern
            when String
              Regexp.new(pattern, flags)
            else
              return text
            end
  rescue RegexpError
    return text
  end
  
  if global
    text.gsub(regex, replacement)
  else
    text.sub(regex, replacement)
  end
end

def regex_split(text, pattern, options = {})
  return [] if text.nil? || pattern.nil?
  
  case_insensitive = options[:case_insensitive] || false
  multiline = options[:multiline] || false
  extended = options[:extended] || false
  limit = options[:limit] || 0
  
  flags = 0
  flags |= Regexp::IGNORECASE if case_insensitive
  flags |= Regexp::MULTILINE if multiline
  flags |= Regexp::EXTENDED if extended
  
  begin
    regex = case pattern
            when Regexp
              pattern
            when String
              Regexp.new(pattern, flags)
            else
              return [text]
            end
  rescue RegexpError
    return [text]
  end
  
  if limit > 0
    text.split(regex, limit)
  else
    text.split(regex)
  end
end

if __FILE__ == $0
  test_text = "Hello World! This is a test. Email: test@example.com Phone: (555) 123-4567"
  
  puts "=== Regex Match Tests ==="
  puts "Text: #{test_text}"
  puts
  
  test_patterns = [
    { pattern: /\b[A-Za-z]+\b/, description: "Words" },
    { pattern: /\d+/, description: "Numbers" },
    { pattern: /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/, description: "Email" },
    { pattern: /\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}/, description: "Phone" },
    { pattern: /(?P<word>\b[A-Za-z]+\b)/, description: "Words with named capture" }
  ]
  
  test_patterns.each do |test|
    puts "Pattern: #{test[:pattern].inspect} (#{test[:description]})"
    
    single_match = regex_match(test_text, test[:pattern])
    puts "Single match: #{single_match.inspect}"
    
    all_matches = regex_match(test_text, test[:pattern], global: true)
    puts "All matches: #{all_matches.inspect}"
    
    named_match = regex_match(test_text, test[:pattern], named_captures: true)
    puts "Named captures: #{named_match.inspect}"
    
    puts "---"
  end
  
  puts "\n=== Regex Replace Tests ==="
  
  replace_tests = [
    { pattern: /\b[A-Za-z]+\b/, replacement: "[WORD]", description: "Replace words" },
    { pattern: /\d+/, replacement: "XXX", description: "Replace numbers" },
    { pattern: /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/, replacement: "[EMAIL]", description: "Replace email" }
  ]
  
  replace_tests.each do |test|
    result = regex_replace(test_text, test[:pattern], test[:replacement])
    puts "#{test[:description]}: #{result}"
  end
  
  puts "\n=== Regex Split Tests ==="
  
  split_tests = [
    { pattern: /\s+/, description: "Split on whitespace" },
    { pattern: /[.!?]+/, description: "Split on punctuation" },
    { pattern: /\b/, description: "Split on word boundaries" }
  ]
  
  split_tests.each do |test|
    result = regex_split(test_text, test[:pattern])
    puts "#{test[:description]}: #{result.inspect}"
  end
end