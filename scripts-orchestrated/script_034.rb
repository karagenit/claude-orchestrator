def rot13(text)
  return "" if text.nil? || text.empty?
  
  result = ""
  
  text.each_char do |char|
    if char.match?(/[a-zA-Z]/)
      if char.match?(/[A-Z]/)
        # Uppercase letters
        base = 'A'.ord
        shifted = ((char.ord - base + 13) % 26) + base
        result += shifted.chr
      else
        # Lowercase letters
        base = 'a'.ord
        shifted = ((char.ord - base + 13) % 26) + base
        result += shifted.chr
      end
    else
      # Non-alphabetic characters remain unchanged
      result += char
    end
  end
  
  result
end

def rot13_encode(text)
  rot13(text)
end

def rot13_decode(text)
  # ROT13 is its own inverse
  rot13(text)
end

def rot13_with_numbers(text)
  return "" if text.nil? || text.empty?
  
  result = ""
  
  text.each_char do |char|
    case char
    when /[a-zA-Z]/
      if char.match?(/[A-Z]/)
        base = 'A'.ord
        shifted = ((char.ord - base + 13) % 26) + base
        result += shifted.chr
      else
        base = 'a'.ord
        shifted = ((char.ord - base + 13) % 26) + base
        result += shifted.chr
      end
    when /[0-9]/
      # ROT5 for numbers (0-9)
      base = '0'.ord
      shifted = ((char.ord - base + 5) % 10) + base
      result += shifted.chr
    else
      # Non-alphanumeric characters remain unchanged
      result += char
    end
  end
  
  result
end

def is_rot13_pair?(text1, text2)
  return false if text1.nil? || text2.nil?
  return false if text1.length != text2.length
  
  rot13(text1) == text2
end