def url_decode(encoded_string)
  return '' if encoded_string.nil?
  
  decoded = ''
  i = 0
  
  while i < encoded_string.length
    if encoded_string[i] == '%' && i + 2 < encoded_string.length
      hex_value = encoded_string[i + 1, 2]
      if hex_value.match(/^[0-9A-Fa-f]{2}$/)
        decoded += [hex_value.to_i(16)].pack('C')
        i += 3
      else
        decoded += encoded_string[i]
        i += 1
      end
    elsif encoded_string[i] == '+'
      decoded += ' '
      i += 1
    else
      decoded += encoded_string[i]
      i += 1
    end
  end
  
  decoded
end

def url_decode_strict(encoded_string)
  return '' if encoded_string.nil?
  
  decoded = ''
  i = 0
  
  while i < encoded_string.length
    if encoded_string[i] == '%' && i + 2 < encoded_string.length
      hex_value = encoded_string[i + 1, 2]
      if hex_value.match(/^[0-9A-Fa-f]{2}$/)
        decoded += [hex_value.to_i(16)].pack('C')
        i += 3
      else
        raise "Invalid URL encoding at position #{i}: #{encoded_string[i, 3]}"
      end
    else
      decoded += encoded_string[i]
      i += 1
    end
  end
  
  decoded
end

def url_decode_with_validation(encoded_string)
  return { decoded: '', valid: false, error: 'Input is nil' } if encoded_string.nil?
  
  decoded = ''
  i = 0
  errors = []
  
  while i < encoded_string.length
    if encoded_string[i] == '%'
      if i + 2 >= encoded_string.length
        errors << "Incomplete percent encoding at position #{i}"
        decoded += encoded_string[i]
        i += 1
      else
        hex_value = encoded_string[i + 1, 2]
        if hex_value.match(/^[0-9A-Fa-f]{2}$/)
          decoded += [hex_value.to_i(16)].pack('C')
          i += 3
        else
          errors << "Invalid hex value '#{hex_value}' at position #{i}"
          decoded += encoded_string[i]
          i += 1
        end
      end
    elsif encoded_string[i] == '+'
      decoded += ' '
      i += 1
    else
      decoded += encoded_string[i]
      i += 1
    end
  end
  
  {
    decoded: decoded,
    valid: errors.empty?,
    errors: errors
  }
end

if __FILE__ == $0
  test_strings = [
    "Hello%20World%21",
    "user%40example.com",
    "path%2Fto%2Fresource%3Fparam%3Dvalue",
    "special%20chars%3A%20%21%40%23%24%25%5E%26%2A%28%29",
    "Hello+World",
    "caf%C3%A9+na%C3%AFve+r%C3%A9sum%C3%A9",
    "invalid%ZZ%encoding",
    "incomplete%2"
  ]
  
  puts "URL Decoding Examples:"
  puts "=" * 50
  
  test_strings.each do |string|
    puts "Encoded:  #{string}"
    puts "Decoded:  #{url_decode(string).inspect}"
    
    result = url_decode_with_validation(string)
    if result[:valid]
      puts "Valid:    #{result[:decoded].inspect}"
    else
      puts "Invalid:  #{result[:errors].join(', ')}"
    end
    puts
  end
  
  puts "Round-trip test:"
  original = "Hello World! Testing 123"
  encoded = "Hello%20World%21%20Testing%20123"
  decoded = url_decode(encoded)
  puts "Original: #{original.inspect}"
  puts "Decoded:  #{decoded.inspect}"
  puts "Match:    #{original == decoded}"
end