def html_unescape(text)
  return nil if text.nil?
  return "" if text.empty?
  
  result = text.dup
  
  result = unescape_named_entities(result)
  result = unescape_numeric_entities(result)
  result = unescape_hex_entities(result)
  
  result
end

def unescape_named_entities(text)
  entity_map = {
    '&amp;' => '&',
    '&lt;' => '<',
    '&gt;' => '>',
    '&quot;' => '"',
    '&#39;' => "'",
    '&apos;' => "'",
    '&#x2F;' => '/',
    '&#x60;' => '`',
    '&#x3D;' => '=',
    '&nbsp;' => ' ',
    '&copy;' => '©',
    '&reg;' => '®',
    '&trade;' => '™',
    '&euro;' => '€',
    '&pound;' => '£',
    '&yen;' => '¥',
    '&cent;' => '¢',
    '&sect;' => '§',
    '&para;' => '¶',
    '&middot;' => '·',
    '&laquo;' => '«',
    '&raquo;' => '»',
    '&hellip;' => '…',
    '&ndash;' => '–',
    '&mdash;' => '—',
    '&lsquo;' => ''',
    '&rsquo;' => ''',
    '&ldquo;' => '"',
    '&rdquo;' => '"'
  }
  
  result = text.dup
  
  entity_map.each do |entity, char|
    result = result.gsub(entity, char)
  end
  
  result
end

def unescape_numeric_entities(text)
  result = text.dup
  
  result = result.gsub(/&#(\d+);/) do |match|
    code_point = $1.to_i
    
    if code_point >= 0 && code_point <= 1114111
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

def unescape_hex_entities(text)
  result = text.dup
  
  result = result.gsub(/&#[xX]([0-9a-fA-F]+);/) do |match|
    code_point = $1.to_i(16)
    
    if code_point >= 0 && code_point <= 1114111
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

if __FILE__ == $0
  test_strings = [
    "Hello World",
    "&lt;script&gt;alert(&#39;XSS&#39;)&lt;/script&gt;",
    "AT&amp;T Corporation",
    "He said &quot;Hello&quot; to me",
    "Rock &amp; Roll",
    "2 &lt; 3 and 4 &gt; 3",
    "Path: &#x2F;home&#x2F;user",
    "Query: name=John&amp;age=25",
    "Template: &#x60;Hello ${name}&#x60;",
    "Comparison: a &#x3D; b",
    "Caf&eacute; &amp; R&eacute;sum&eacute;",
    "&#20013;&#25991;&#27979;&#35797;",
    "&copy; 2023 &reg; &trade;",
    "&euro;100 &pound;50 &yen;1000",
    "&nbsp;&nbsp;Spaced&nbsp;&nbsp;",
    "&#65;&#66;&#67;",
    "&#x41;&#x42;&#x43;",
    "",
    nil
  ]
  
  test_strings.each do |text|
    unescaped = html_unescape(text)
    puts "Original:   #{text.inspect}"
    puts "Unescaped:  #{unescaped.inspect}"
    puts "---"
  end
end