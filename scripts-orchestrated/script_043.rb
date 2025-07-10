def credit_card_mask(card_number, options = {})
  return nil if card_number.nil?
  return "" if card_number.strip.empty?
  
  cleaned_number = card_number.gsub(/[^\d]/, '')
  
  return card_number if cleaned_number.length < 13 || cleaned_number.length > 19
  
  mask_char = options[:mask_char] || '*'
  show_first = options[:show_first] || 4
  show_last = options[:show_last] || 4
  preserve_format = options[:preserve_format] || false
  
  return card_number if show_first + show_last >= cleaned_number.length
  
  first_digits = cleaned_number[0, show_first]
  last_digits = cleaned_number[-show_last, show_last]
  middle_length = cleaned_number.length - show_first - show_last
  masked_middle = mask_char * middle_length
  
  masked_number = first_digits + masked_middle + last_digits
  
  if preserve_format
    return apply_original_format(masked_number, card_number)
  else
    return format_card_number(masked_number, detect_card_type(cleaned_number))
  end
end

def detect_card_type(number)
  return :unknown if number.nil? || number.empty?
  
  case number
  when /\A4/
    :visa
  when /\A5[1-5]/, /\A2[2-7]/
    :mastercard
  when /\A3[47]/
    :amex
  when /\A6(?:011|5)/
    :discover
  when /\A30[0-5]/, /\A36/, /\A38/
    :diners
  when /\A35/
    :jcb
  else
    :unknown
  end
end

def format_card_number(number, card_type)
  return number if number.nil? || number.empty?
  
  case card_type
  when :amex
    if number.length == 15
      "#{number[0..3]} #{number[4..9]} #{number[10..14]}"
    else
      number
    end
  when :diners
    if number.length == 14
      "#{number[0..3]} #{number[4..9]} #{number[10..13]}"
    else
      number
    end
  else
    number.scan(/.{1,4}/).join(' ')
  end
end

def apply_original_format(masked_number, original)
  result = ""
  masked_index = 0
  
  original.each_char do |char|
    if char.match?(/\d/)
      if masked_index < masked_number.length
        result += masked_number[masked_index]
        masked_index += 1
      end
    else
      result += char
    end
  end
  
  result
end

if __FILE__ == $0
  test_cards = [
    "4532-1234-5678-9012",
    "5555 5555 5555 4444",
    "378282246310005",
    "6011111111111117",
    "30569309025904",
    "4111111111111111",
    "invalid-card",
    "123"
  ]
  
  test_cards.each do |card|
    masked = credit_card_mask(card)
    puts "#{card} -> #{masked}"
  end
  
  puts "\nWith custom options:"
  puts credit_card_mask("4532-1234-5678-9012", mask_char: 'X', show_first: 6, show_last: 2)
  puts credit_card_mask("4532-1234-5678-9012", preserve_format: true)
end