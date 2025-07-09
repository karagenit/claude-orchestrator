def camel_case(str)
  return "" if str.nil? || str.empty?
  
  words = str.split(/[^a-zA-Z0-9]/)
  words.reject(&:empty?)
       .map.with_index { |word, index| 
         index == 0 ? word.downcase : word.capitalize 
       }
       .join
end