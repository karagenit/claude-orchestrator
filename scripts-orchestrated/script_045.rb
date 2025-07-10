def html_escape(text)
  return nil if text.nil?
  return "" if text.empty?
  
  escape_map = {
    '&' => '&amp;',
    '<' => '&lt;',
    '>' => '&gt;',
    '"' => '&quot;',
    "'" => '&#39;',
    '/' => '&#x2F;',
    '`' => '&#x60;',
    '=' => '&#x3D;'
  }
  
  result = text.dup
  
  escape_map.each do |char, escaped|
    result = result.gsub(char, escaped)
  end
  
  result = escape_control_characters(result)
  result = escape_unicode_characters(result)
  
  result
end

def escape_control_characters(text)
  result = text.dup
  
  (0..31).each do |code|
    next if [9, 10, 13].include?(code)
    
    char = code.chr
    result = result.gsub(char, "&##{code};")
  end
  
  (127..159).each do |code|
    char = code.chr(Encoding::UTF_8) rescue next
    result = result.gsub(char, "&##{code};")
  end
  
  result
end

def escape_unicode_characters(text)
  result = ""
  
  text.each_char do |char|
    code_point = char.ord
    
    if code_point > 127
      if code_point <= 0xFFFF
        result += "&#x#{code_point.to_s(16).upcase};"
      else
        result += "&#x#{code_point.to_s(16).upcase};"
      end
    else
      result += char
    end
  end
  
  result
end

if __FILE__ == $0
  test_strings = [
    "Hello World",
    "<script>alert('XSS')</script>",
    "AT&T Corporation",
    'He said "Hello" to me',
    "Rock & Roll",
    "2 < 3 and 4 > 3",
    "Path: /home/user",
    "Query: name=John&age=25",
    "Template: `Hello ${name}`",
    "Comparison: a = b",
    "Café & Résumé",
    "中文测试",
    "",
    nil
  ]
  
  test_strings.each do |text|
    escaped = html_escape(text)
    puts "Original: #{text.inspect}"
    puts "Escaped:  #{escaped.inspect}"
    puts "---"
  end
end