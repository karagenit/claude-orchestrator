def phone_number_format(phone)
  return "" if phone.nil? || phone.empty?
  
  digits = phone.gsub(/\D/, '')
  
  return "" if digits.length < 10
  
  if digits.length == 10
    "(#{digits[0, 3]}) #{digits[3, 3]}-#{digits[6, 4]}"
  elsif digits.length == 11 && digits[0] == '1'
    "+1 (#{digits[1, 3]}) #{digits[4, 3]}-#{digits[7, 4]}"
  else
    ""
  end
end