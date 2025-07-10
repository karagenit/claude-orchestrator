def base64_decode(encoded_string)
  return '' if encoded_string.nil? || encoded_string.empty?
  
  base64_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  char_map = {}
  base64_chars.each_char.with_index { |char, index| char_map[char] = index }
  
  encoded = encoded_string.gsub(/\s/, '')
  decoded = ''
  
  i = 0
  while i < encoded.length
    break if encoded.length - i < 4
    
    char1 = char_map[encoded[i]] || 0
    char2 = char_map[encoded[i + 1]] || 0
    char3 = encoded[i + 2] == '=' ? 0 : (char_map[encoded[i + 2]] || 0)
    char4 = encoded[i + 3] == '=' ? 0 : (char_map[encoded[i + 3]] || 0)
    
    combined = (char1 << 18) | (char2 << 12) | (char3 << 6) | char4
    
    decoded += ((combined >> 16) & 0xFF).chr
    decoded += ((combined >> 8) & 0xFF).chr if encoded[i + 2] != '='
    decoded += (combined & 0xFF).chr if encoded[i + 3] != '='
    
    i += 4
  end
  
  decoded
end

def base64_decode_url_safe(encoded_string)
  return '' if encoded_string.nil? || encoded_string.empty?
  
  normalized = encoded_string.tr('-_', '+/')
  
  case normalized.length % 4
  when 2
    normalized += '=='
  when 3
    normalized += '='
  end
  
  base64_decode(normalized)
end

def base64_decode_with_validation(encoded_string)
  return { decoded: '', valid: false, error: 'Input is nil or empty' } if encoded_string.nil? || encoded_string.empty?
  
  base64_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  
  cleaned = encoded_string.gsub(/\s/, '')
  
  if cleaned.length % 4 != 0
    return { decoded: '', valid: false, error: 'Invalid length - must be multiple of 4' }
  end
  
  invalid_chars = cleaned.chars.select { |char| !base64_chars.include?(char) && char != '=' }
  if invalid_chars.any?
    return { decoded: '', valid: false, error: "Invalid characters: #{invalid_chars.uniq.join(', ')}" }
  end
  
  padding_pos = cleaned.index('=')
  if padding_pos
    after_padding = cleaned[padding_pos + 1..-1]
    if after_padding.chars.any? { |char| char != '=' }
      return { decoded: '', valid: false, error: 'Invalid padding - non-padding chars after padding' }
    end
  end
  
  decoded = base64_decode(cleaned)
  { decoded: decoded, valid: true, error: nil }
end

if __FILE__ == $0
  test_cases = [
    "SGVsbG8gV29ybGQh",
    "VGhlIHF1aWNrIGJyb3duIGZveCBqdW1wcyBvdmVyIHRoZSBsYXp5IGRvZw==",
    "QQ==",
    "QUI=",
    "QUJD",
    "QUJDRA==",
    "",
    "SGVsbG8gV29ybGQh\n",
    "SGVsbG8tV29ybGQh",
    "SGVsbG8_V29ybGQh",
    "InvalidBase64!",
    "SGVsbG8gV29ybGQ"
  ]
  
  puts "Base64 Decoding Examples:"
  puts "=" * 60
  
  test_cases.each do |encoded|
    puts "Encoded:  #{encoded.inspect}"
    
    result = base64_decode_with_validation(encoded)
    if result[:valid]
      puts "Decoded:  #{result[:decoded].inspect}"
    else
      puts "Error:    #{result[:error]}"
    end
    
    url_safe_decoded = base64_decode_url_safe(encoded)
    puts "URL-safe: #{url_safe_decoded.inspect}" unless url_safe_decoded.empty?
    puts
  end
  
  puts "Round-trip test:"
  original = "Hello World! Testing 123 with special chars: !@#$%^&*()"
  encoded = "SGVsbG8gV29ybGQhIFRlc3RpbmcgMTIzIHdpdGggc3BlY2lhbCBjaGFyczogIUAjJCVeJiooKQ=="
  decoded = base64_decode(encoded)
  puts "Original: #{original.inspect}"
  puts "Decoded:  #{decoded.inspect}"
  puts "Match:    #{original == decoded}"
end