def random_string(length = 10, options = {})
  return "" if length <= 0
  
  charset = build_charset(options)
  return "" if charset.empty?
  
  result = ""
  length.times do
    result += charset[rand(charset.length)]
  end
  
  result
end

def build_charset(options)
  charset = ""
  
  # Default behavior: include letters and numbers
  if options.empty?
    charset += ('a'..'z').to_a.join
    charset += ('A'..'Z').to_a.join
    charset += ('0'..'9').to_a.join
    return charset
  end
  
  # Build charset based on options
  charset += ('a'..'z').to_a.join if options[:lowercase] || options[:letters]
  charset += ('A'..'Z').to_a.join if options[:uppercase] || options[:letters]
  charset += ('0'..'9').to_a.join if options[:numbers] || options[:digits]
  charset += "!@#$%^&*()_+-=[]{}|;:,.<>?" if options[:symbols] || options[:special]
  charset += " " if options[:spaces]
  charset += options[:custom] if options[:custom]
  
  # Remove duplicates and return
  charset.chars.uniq.join
end

def random_hex_string(length = 16)
  hex_chars = "0123456789abcdef"
  result = ""
  
  length.times do
    result += hex_chars[rand(hex_chars.length)]
  end
  
  result
end

def random_alphanumeric(length = 10)
  random_string(length, letters: true, numbers: true)
end

def random_alpha(length = 10)
  random_string(length, letters: true)
end

def random_numeric_string(length = 10)
  random_string(length, numbers: true)
end

def random_password(length = 12, options = {})
  # Default secure password options
  default_options = {
    lowercase: true,
    uppercase: true,
    numbers: true,
    symbols: true
  }
  
  merged_options = default_options.merge(options)
  
  # Ensure minimum requirements
  if length < 4 && merged_options.values.count(true) > 1
    raise ArgumentError, "Password length too short for required character types"
  end
  
  password = random_string(length, merged_options)
  
  # Ensure at least one character from each required type
  ensure_character_requirements(password, merged_options)
end

def ensure_character_requirements(password, options)
  password = password.dup
  charset_map = {
    lowercase: ('a'..'z').to_a,
    uppercase: ('A'..'Z').to_a,
    numbers: ('0'..'9').to_a,
    symbols: "!@#$%^&*()_+-=[]{}|;:,.<>?".chars
  }
  
  options.each do |type, required|
    next unless required
    
    chars = charset_map[type]
    next unless chars
    
    # Check if password already contains this character type
    unless password.chars.any? { |char| chars.include?(char) }
      # Replace a random character with one from the required type
      random_index = rand(password.length)
      password[random_index] = chars[rand(chars.length)]
    end
  end
  
  password
end

def random_uuid
  # Generate a random UUID v4
  hex = random_hex_string(32)
  
  # Format as UUID: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
  # where y is 8, 9, A, or B
  uuid = hex[0..7] + "-" + hex[8..11] + "-4" + hex[12..14] + "-"
  
  # Set the two most significant bits of the 7th byte to 10
  y_char = ['8', '9', 'a', 'b'][rand(4)]
  uuid += y_char + hex[16..18] + "-" + hex[19..30]
  
  uuid
end

def random_sentence(word_count = 5, options = {})
  min_word_length = options[:min_word_length] || 3
  max_word_length = options[:max_word_length] || 8
  
  words = []
  
  word_count.times do
    word_length = rand(max_word_length - min_word_length + 1) + min_word_length
    word = random_string(word_length, lowercase: true)
    words << word
  end
  
  sentence = words.join(" ")
  sentence[0] = sentence[0].upcase if sentence.length > 0
  sentence += "."
  
  sentence
end