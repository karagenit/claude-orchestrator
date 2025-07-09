def binary_to_decimal(binary_str)
  return 0 if binary_str.nil? || binary_str.empty?
  
  decimal = 0
  
  binary_str.each_char.with_index do |char, index|
    return 0 unless char == '0' || char == '1'
    
    power = binary_str.length - 1 - index
    decimal += char.to_i * (2 ** power)
  end
  
  decimal
end