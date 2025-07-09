def kebab_case(str)
  return "" if str.nil? || str.empty?
  
  str.gsub(/([a-z0-9])([A-Z])/, '\1-\2')
     .gsub(/[^a-zA-Z0-9]/, '-')
     .gsub(/-+/, '-')
     .gsub(/^-|-$/, '')
     .downcase
end