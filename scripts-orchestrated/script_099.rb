def log_parser(log_file_path, filters = {})
  return [] if log_file_path.nil? || !File.exist?(log_file_path)
  
  parsed_logs = []
  
  begin
    File.foreach(log_file_path) do |line|
      line.strip!
      next if line.empty?
      
      log_entry = parse_log_line(line)
      next if log_entry.nil?
      
      if matches_filters?(log_entry, filters)
        parsed_logs << log_entry
      end
    end
  rescue => e
    return []
  end
  
  parsed_logs
end

def parse_log_line(line)
  log_entry = {}
  
  timestamp_match = line.match(/(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})/)
  if timestamp_match
    log_entry[:timestamp] = timestamp_match[1]
  end
  
  level_match = line.match(/\[(DEBUG|INFO|WARN|ERROR|FATAL)\]/)
  if level_match
    log_entry[:level] = level_match[1]
  end
  
  message_match = line.match(/(?:\[#{level_match ? level_match[1] : '\w+'}\])?\s*(.+)$/)
  if message_match
    log_entry[:message] = message_match[1].strip
  end
  
  log_entry[:raw] = line
  log_entry
end

def matches_filters?(log_entry, filters)
  return true if filters.empty?
  
  filters.each do |key, value|
    case key
    when :level
      return false unless log_entry[:level] == value
    when :message_contains
      return false unless log_entry[:message] && log_entry[:message].include?(value)
    when :after_time
      return false unless log_entry[:timestamp] && log_entry[:timestamp] >= value
    when :before_time
      return false unless log_entry[:timestamp] && log_entry[:timestamp] <= value
    end
  end
  
  true
end