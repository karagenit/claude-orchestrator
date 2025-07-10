def base64_encode(string)
  return '' if string.nil?
  
  base64_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  encoded = ''
  
  i = 0
  while i < string.length
    byte1 = string[i].ord
    byte2 = i + 1 < string.length ? string[i + 1].ord : 0
    byte3 = i + 2 < string.length ? string[i + 2].ord : 0
    
    combined = (byte1 << 16) | (byte2 << 8) | byte3
    
    encoded += base64_chars[(combined >> 18) & 63]
    encoded += base64_chars[(combined >> 12) & 63]
    encoded += i + 1 < string.length ? base64_chars[(combined >> 6) & 63] : '='
    encoded += i + 2 < string.length ? base64_chars[combined & 63] : '='
    
    i += 3
  end
  
  encoded
end

def base64_encode_chunked(string, line_length = 76)
  return '' if string.nil?
  
  encoded = base64_encode(string)
  return encoded if line_length <= 0
  
  chunked = ''
  i = 0
  
  while i < encoded.length
    chunk_end = [i + line_length, encoded.length].min
    chunked += encoded[i...chunk_end]
    chunked += "\n" if chunk_end < encoded.length
    i += line_length
  end
  
  chunked
end

def base64_encode_url_safe(string)
  return '' if string.nil?
  
  encoded = base64_encode(string)
  encoded.tr('+/', '-_').gsub(/=+$/, '')
end

def base64_encode_with_stats(string)
  return { encoded: '', stats: { original_length: 0, encoded_length: 0, padding: 0 } } if string.nil?
  
  encoded = base64_encode(string)
  padding = encoded.count('=')
  
  {
    encoded: encoded,
    stats: {
      original_length: string.length,
      encoded_length: encoded.length,
      padding: padding,
      efficiency: (string.length.to_f / encoded.length * 100).round(2)
    }
  }
end

if __FILE__ == $0
  test_strings = [
    "Hello World!",
    "The quick brown fox jumps over the lazy dog",
    "A",
    "AB",
    "ABC",
    "ABCD",
    "",
    "Binary data: \x00\x01\x02\x03\xFF\xFE\xFD",
    "Unicode: café naïve résumé 🎉"
  ]
  
  puts "Base64 Encoding Examples:"
  puts "=" * 60
  
  test_strings.each do |string|
    result = base64_encode_with_stats(string)
    puts "Original: #{string.inspect}"
    puts "Encoded:  #{result[:encoded]}"
    puts "Stats:    #{result[:stats]}"
    puts "URL-safe: #{base64_encode_url_safe(string)}"
    puts
  end
  
  puts "Chunked encoding (16 chars per line):"
  long_string = "This is a longer string that will be chunked into multiple lines for better readability."
  chunked = base64_encode_chunked(long_string, 16)
  puts chunked
  puts
  
  puts "Binary data test:"
  binary_data = (0..255).map(&:chr).join
  encoded_binary = base64_encode(binary_data)
  puts "Binary data (256 bytes) encoded to #{encoded_binary.length} characters"
end