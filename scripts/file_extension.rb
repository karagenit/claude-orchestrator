def file_extension(filename)
  return "" if filename.nil? || filename.empty?
  
  last_dot = filename.rindex('.')
  
  return "" if last_dot.nil? || last_dot == filename.length - 1
  
  filename[last_dot + 1..-1]
end