def caesar_cipher(text, shift)
  return "" if text.nil? || text.empty?
  
  # Normalize shift to be within 0-25 range
  shift = shift % 26
  
  result = ""
  
  text.each_char do |char|
    if char.match?(/[a-zA-Z]/)
      # Determine if uppercase or lowercase
      if char.match?(/[A-Z]/)
        # Uppercase letters
        base = 'A'.ord
        shifted = ((char.ord - base + shift) % 26) + base
        result += shifted.chr
      else
        # Lowercase letters
        base = 'a'.ord
        shifted = ((char.ord - base + shift) % 26) + base
        result += shifted.chr
      end
    else
      # Non-alphabetic characters remain unchanged
      result += char
    end
  end
  
  result
end

def caesar_decipher(text, shift)
  caesar_cipher(text, -shift)
end

def find_most_likely_shift(ciphertext)
  # Common English letter frequencies
  english_freq = {
    'E' => 12.7, 'T' => 9.1, 'A' => 8.2, 'O' => 7.5, 'I' => 7.0,
    'N' => 6.7, 'S' => 6.3, 'H' => 6.1, 'R' => 6.0, 'D' => 4.3
  }
  
  best_shift = 0
  best_score = 0
  
  (0...26).each do |shift|
    decoded = caesar_decipher(ciphertext, shift)
    score = calculate_frequency_score(decoded, english_freq)
    
    if score > best_score
      best_score = score
      best_shift = shift
    end
  end
  
  best_shift
end

def calculate_frequency_score(text, target_freq)
  letter_count = Hash.new(0)
  total_letters = 0
  
  text.upcase.each_char do |char|
    if char.match?(/[A-Z]/)
      letter_count[char] += 1
      total_letters += 1
    end
  end
  
  return 0 if total_letters == 0
  
  score = 0
  target_freq.each do |letter, expected_freq|
    actual_freq = (letter_count[letter] * 100.0) / total_letters
    score += (expected_freq - (actual_freq - expected_freq).abs)
  end
  
  score
end