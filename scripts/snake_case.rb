def snake_case(str)
  return "" if str.nil? || str.empty?
  
  str.gsub(/([a-z0-9])([A-Z])/, '\1_\2')
     .gsub(/[^a-zA-Z0-9]/, '_')
     .gsub(/_+/, '_')
     .gsub(/^_|_$/, '')
     .downcase
end