def count_files_in_directory(dir_path)
  return 0 unless Dir.exist?(dir_path)
  
  count = 0
  Dir.entries(dir_path).each do |entry|
    next if entry == '.' || entry == '..'
    
    full_path = File.join(dir_path, entry)
    if File.file?(full_path)
      count += 1
    elsif File.directory?(full_path)
      count += count_files_in_directory(full_path)
    end
  end
  
  count
end