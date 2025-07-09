def extract_numbers(str)
  return [] if str.nil? || str.empty?
  
  numbers = []
  current_number = ""
  
  str.each_char do |char|
    if char.match(/[0-9.-]/)
      current_number += char
    else
      if !current_number.empty?
        numbers << current_number.to_f
        current_number = ""
      end
    end
  end
  
  numbers << current_number.to_f if !current_number.empty?
  numbers
end