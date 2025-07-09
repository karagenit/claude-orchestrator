def hex_to_decimal(hex_str)
  return 0 if hex_str.nil? || hex_str.empty?
  
  hex_str = hex_str.upcase.gsub(/^0X/, '')
  decimal = 0
  
  hex_str.each_char.with_index do |char, index|
    power = hex_str.length - 1 - index
    
    if char >= '0' && char <= '9'
      digit = char.ord - '0'.ord
    elsif char >= 'A' && char <= 'F'
      digit = char.ord - 'A'.ord + 10
    else
      return 0
    end
    
    decimal += digit * (16 ** power)
  end
  
  decimal
end