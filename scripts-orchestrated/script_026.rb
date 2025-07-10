def url_encode(string)
  return '' if string.nil?
  
  encoded = ''
  
  string.each_byte do |byte|
    char = byte.chr
    if char.match(/[A-Za-z0-9\-_.~]/)
      encoded += char
    else
      encoded += sprintf('%%%02X', byte)
    end
  end
  
  encoded
end

def url_encode_spaces_as_plus(string)
  return '' if string.nil?
  
  encoded = ''
  
  string.each_byte do |byte|
    char = byte.chr
    if char == ' '
      encoded += '+'
    elsif char.match(/[A-Za-z0-9\-_.~]/)
      encoded += char
    else
      encoded += sprintf('%%%02X', byte)
    end
  end
  
  encoded
end

def url_encode_component(string)
  return '' if string.nil?
  
  encoded = ''
  
  string.each_byte do |byte|
    char = byte.chr
    if char.match(/[A-Za-z0-9\-_.~!'()*]/)
      encoded += char
    else
      encoded += sprintf('%%%02X', byte)
    end
  end
  
  encoded
end

def batch_url_encode(strings)
  return [] if strings.nil?
  
  results = []
  
  strings.each do |string|
    results << {
      original: string,
      encoded: url_encode(string),
      encoded_with_plus: url_encode_spaces_as_plus(string)
    }
  end
  
  results
end

if __FILE__ == $0
  test_strings = [
    "Hello World!",
    "user@example.com",
    "path/to/resource?param=value",
    "special chars: !@#$%^&*()",
    "unicode: café naïve résumé",
    "spaces and tabs\tand\nnewlines"
  ]
  
  puts "URL Encoding Examples:"
  puts "=" * 50
  
  test_strings.each do |string|
    puts "Original: #{string.inspect}"
    puts "Encoded:  #{url_encode(string)}"
    puts "With +:   #{url_encode_spaces_as_plus(string)}"
    puts
  end
  
  puts "Batch encoding:"
  batch_results = batch_url_encode(["hello world", "test@example.com"])
  batch_results.each_with_index do |result, index|
    puts "#{index + 1}. #{result[:original]} -> #{result[:encoded]}"
  end
end