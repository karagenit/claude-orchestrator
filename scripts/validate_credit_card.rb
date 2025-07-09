def validate_credit_card(card_number)
  return false if card_number.nil? || card_number.empty?
  
  digits = card_number.gsub(/\D/, '')
  
  return false if digits.length < 13 || digits.length > 19
  
  sum = 0
  alternate = false
  
  (digits.length - 1).downto(0) do |i|
    digit = digits[i].to_i
    
    if alternate
      digit *= 2
      digit = digit / 10 + digit % 10 if digit > 9
    end
    
    sum += digit
    alternate = !alternate
  end
  
  sum % 10 == 0
end