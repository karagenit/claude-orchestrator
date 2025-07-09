def pascal_case(str)
  return "" if str.nil? || str.empty?
  
  str.split(/[^a-zA-Z0-9]/)
     .reject(&:empty?)
     .map(&:capitalize)
     .join
end