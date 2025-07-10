def validate_phone(phone)
  return false if phone.nil? || phone.strip.empty?
  
  cleaned_phone = phone.gsub(/[^\d+]/, '')
  
  return false if cleaned_phone.empty?
  
  if cleaned_phone.start_with?('+')
    return false if cleaned_phone.length < 8 || cleaned_phone.length > 18
    
    country_code_part = cleaned_phone[1..]
    return false unless country_code_part.match?(/\A\d+\z/)
    
    return false if country_code_part.length < 7 || country_code_part.length > 15
    
    country_code = country_code_part[0..2]
    return false unless valid_country_code?(country_code)
    
  elsif cleaned_phone.start_with?('1') && cleaned_phone.length == 11
    area_code = cleaned_phone[1..3]
    return false unless valid_us_area_code?(area_code)
    
    exchange = cleaned_phone[4..6]
    return false if exchange.start_with?('0', '1')
    
    number = cleaned_phone[7..10]
    return false unless number.match?(/\A\d{4}\z/)
    
  elsif cleaned_phone.length == 10
    area_code = cleaned_phone[0..2]
    return false unless valid_us_area_code?(area_code)
    
    exchange = cleaned_phone[3..5]
    return false if exchange.start_with?('0', '1')
    
    number = cleaned_phone[6..9]
    return false unless number.match?(/\A\d{4}\z/)
    
  else
    return false unless cleaned_phone.length >= 7 && cleaned_phone.length <= 15
    return false unless cleaned_phone.match?(/\A\d+\z/)
  end
  
  true
end

def valid_country_code?(code)
  return false if code.nil? || code.empty?
  
  code_int = code.to_i
  return false if code_int < 1 || code_int > 999
  
  common_codes = [1, 7, 20, 27, 30, 31, 32, 33, 34, 36, 39, 40, 41, 43, 44, 45, 46, 47, 48, 49, 
                  51, 52, 53, 54, 55, 56, 57, 58, 60, 61, 62, 63, 64, 65, 66, 81, 82, 84, 86, 90, 
                  91, 92, 93, 94, 95, 98, 212, 213, 216, 218, 220, 221, 222, 223, 224, 225, 226, 
                  227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 
                  243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 
                  260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 290, 291, 297, 298, 299, 350, 
                  351, 352, 353, 354, 355, 356, 357, 358, 359, 370, 371, 372, 373, 374, 375, 376, 
                  377, 378, 380, 381, 382, 383, 385, 386, 387, 389, 420, 421, 423, 500, 501, 502, 
                  503, 504, 505, 506, 507, 508, 509, 590, 591, 592, 593, 594, 595, 596, 597, 598, 
                  599, 670, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 
                  686, 687, 688, 689, 690, 691, 692, 850, 852, 853, 855, 856, 880, 886, 960, 961, 
                  962, 963, 964, 965, 966, 967, 968, 970, 971, 972, 973, 974, 975, 976, 977, 992, 
                  993, 994, 995, 996, 998]
  
  common_codes.include?(code_int)
end

def valid_us_area_code?(area_code)
  return false if area_code.nil? || area_code.length != 3
  return false if area_code.start_with?('0', '1')
  return false if area_code[1] == '9'
  
  code_int = area_code.to_i
  return false if code_int < 200 || code_int > 999
  
  true
end

if __FILE__ == $0
  test_phones = [
    "+1-555-123-4567",
    "555-123-4567",
    "(555) 123-4567",
    "5551234567",
    "+44 20 7946 0958",
    "invalid-phone",
    "123",
    "+1234567890123456789",
    "011234567"
  ]
  
  test_phones.each do |phone|
    result = validate_phone(phone)
    puts "#{phone}: #{result ? 'VALID' : 'INVALID'}"
  end
end