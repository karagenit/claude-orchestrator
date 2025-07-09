def slugify(str)
  return "" if str.nil? || str.empty?
  
  str.downcase
     .gsub(/[^a-z0-9\s-]/, '')
     .gsub(/\s+/, '-')
     .gsub(/-+/, '-')
     .gsub(/^-|-$/, '')
end