def file_size_format(bytes)
  return "0 B" if bytes == 0
  
  units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB']
  size = bytes.to_f
  unit_index = 0
  
  while size >= 1024 && unit_index < units.length - 1
    size /= 1024
    unit_index += 1
  end
  
  if size == size.to_i
    "#{size.to_i} #{units[unit_index]}"
  else
    "#{sprintf('%.2f', size)} #{units[unit_index]}"
  end
end