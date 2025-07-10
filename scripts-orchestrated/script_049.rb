def xml_escape(text)
  return nil if text.nil?
  return "" if text.empty?
  
  escape_map = {
    '&' => '&amp;',
    '<' => '&lt;',
    '>' => '&gt;',
    '"' => '&quot;',
    "'" => '&apos;'
  }
  
  result = text.dup
  
  escape_map.each do |char, escaped|
    result = result.gsub(char, escaped)
  end
  
  result = escape_xml_control_characters(result)
  result = escape_xml_unicode_characters(result)
  
  result
end

def escape_xml_control_characters(text)
  result = text.dup
  
  (0..31).each do |code|
    next if [9, 10, 13].include?(code)
    
    char = code.chr
    result = result.gsub(char, "&##{code};")
  end
  
  result
end

def escape_xml_unicode_characters(text)
  result = ""
  
  text.each_char do |char|
    code_point = char.ord
    
    if code_point > 127
      result += "&##{code_point};"
    else
      result += char
    end
  end
  
  result
end

def xml_unescape(text)
  return nil if text.nil?
  return "" if text.empty?
  
  result = text.dup
  
  unescape_map = {
    '&amp;' => '&',
    '&lt;' => '<',
    '&gt;' => '>',
    '&quot;' => '"',
    '&apos;' => "'"
  }
  
  unescape_map.each do |escaped, char|
    result = result.gsub(escaped, char)
  end
  
  result = unescape_xml_numeric_entities(result)
  
  result
end

def unescape_xml_numeric_entities(text)
  result = text.dup
  
  result = result.gsub(/&#(\d+);/) do |match|
    code_point = $1.to_i
    
    if valid_xml_character?(code_point)
      begin
        [code_point].pack('U')
      rescue
        match
      end
    else
      match
    end
  end
  
  result = result.gsub(/&#[xX]([0-9a-fA-F]+);/) do |match|
    code_point = $1.to_i(16)
    
    if valid_xml_character?(code_point)
      begin
        [code_point].pack('U')
      rescue
        match
      end
    else
      match
    end
  end
  
  result
end

def valid_xml_character?(code_point)
  return false if code_point < 0
  
  return true if code_point == 0x09 || code_point == 0x0A || code_point == 0x0D
  return true if code_point >= 0x20 && code_point <= 0xD7FF
  return true if code_point >= 0xE000 && code_point <= 0xFFFD
  return true if code_point >= 0x10000 && code_point <= 0x10FFFF
  
  false
end

if __FILE__ == $0
  test_strings = [
    "Hello World",
    "<root>content</root>",
    "AT&T Corporation",
    'He said "Hello" to me',
    "Rock & Roll",
    "Value: 'test'",
    "2 < 3 and 4 > 3",
    "Mixed: <tag attr=\"value\">content</tag>",
    "Control\x01character",
    "Tab\there",
    "Newline\nhere",
    "Carriage\rreturn",
    "Café & Résumé",
    "中文测试",
    "",
    nil
  ]
  
  puts "=== XML Escape Tests ==="
  test_strings.each do |text|
    escaped = xml_escape(text)
    puts "Original: #{text.inspect}"
    puts "Escaped:  #{escaped.inspect}"
    puts "---"
  end
  
  puts "\n=== XML Unescape Tests ==="
  escaped_strings = [
    "&lt;root&gt;content&lt;/root&gt;",
    "AT&amp;T Corporation",
    "He said &quot;Hello&quot; to me",
    "Rock &amp; Roll",
    "Value: &apos;test&apos;",
    "2 &lt; 3 and 4 &gt; 3",
    "Mixed: &lt;tag attr=&quot;value&quot;&gt;content&lt;/tag&gt;",
    "&#67;&#97;&#102;&#233;",
    "&#x43;&#x61;&#x66;&#xe9;",
    "&#20013;&#25991;&#27979;&#35797;"
  ]
  
  escaped_strings.each do |text|
    unescaped = xml_unescape(text)
    puts "Escaped:   #{text.inspect}"
    puts "Unescaped: #{unescaped.inspect}"
    puts "---"
  end
end