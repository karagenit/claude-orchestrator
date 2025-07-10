def directory_tree(path, max_depth = nil, current_depth = 0)
  return nil if path.nil? || !Dir.exist?(path)
  return nil if max_depth && current_depth > max_depth
  
  tree = {}
  tree['name'] = File.basename(path)
  tree['type'] = 'directory'
  tree['path'] = path
  tree['children'] = []
  
  begin
    entries = Dir.entries(path).reject { |entry| entry == '.' || entry == '..' }
    entries.sort!
    
    entries.each do |entry|
      entry_path = File.join(path, entry)
      
      if File.directory?(entry_path)
        if max_depth.nil? || current_depth < max_depth
          child_tree = directory_tree(entry_path, max_depth, current_depth + 1)
          tree['children'] << child_tree if child_tree
        end
      else
        file_info = {
          'name' => entry,
          'type' => 'file',
          'path' => entry_path,
          'size' => File.size(entry_path),
          'modified' => File.mtime(entry_path)
        }
        tree['children'] << file_info
      end
    end
  rescue => e
    tree['error'] = e.message
  end
  
  tree
end

def print_tree(tree, indent = 0)
  return if tree.nil?
  
  prefix = '  ' * indent
  puts "#{prefix}#{tree['name']} (#{tree['type']})"
  
  if tree['children']
    tree['children'].each do |child|
      print_tree(child, indent + 1)
    end
  end
end