def date_format(date_input, format_string = "%Y-%m-%d")
  begin
    date_obj = case date_input
    when Time
      date_input
    when Date
      date_input.to_time
    when String
      parse_date_string(date_input)
    when Integer
      Time.at(date_input)
    else
      raise ArgumentError, "Unsupported date input type: #{date_input.class}"
    end
    
    format_date_object(date_obj, format_string)
  rescue => e
    puts "Date formatting error: #{e.message}" if $DEBUG
    return date_input.to_s
  end
end

def parse_date_string(date_string)
  date_string = date_string.strip
  
  # Try common date formats
  formats = [
    "%Y-%m-%d",           # 2023-12-25
    "%m/%d/%Y",           # 12/25/2023
    "%d/%m/%Y",           # 25/12/2023
    "%Y/%m/%d",           # 2023/12/25
    "%B %d, %Y",          # December 25, 2023
    "%d %B %Y",           # 25 December 2023
    "%Y-%m-%d %H:%M:%S",  # 2023-12-25 15:30:45
    "%m/%d/%Y %H:%M:%S",  # 12/25/2023 15:30:45
    "%Y-%m-%dT%H:%M:%S",  # ISO 8601 format
    "%Y-%m-%dT%H:%M:%SZ", # ISO 8601 with Z
  ]
  
  formats.each do |format|
    begin
      return Time.strptime(date_string, format)
    rescue ArgumentError
      next
    end
  end
  
  # If no format matches, try built-in parsing
  Time.parse(date_string)
end

def format_date_object(date_obj, format_string)
  # Replace custom format tokens with strftime equivalents
  formatted = format_string.dup
  
  # Custom tokens
  token_replacements = {
    'YYYY' => date_obj.year.to_s,
    'YY' => date_obj.year.to_s[-2..-1],
    'MM' => sprintf("%02d", date_obj.month),
    'M' => date_obj.month.to_s,
    'DD' => sprintf("%02d", date_obj.day),
    'D' => date_obj.day.to_s,
    'HH' => sprintf("%02d", date_obj.hour),
    'H' => date_obj.hour.to_s,
    'mm' => sprintf("%02d", date_obj.min),
    'm' => date_obj.min.to_s,
    'SS' => sprintf("%02d", date_obj.sec),
    'S' => date_obj.sec.to_s,
    'DDD' => get_day_name(date_obj.wday),
    'dd' => get_day_name(date_obj.wday)[0..2],
    'MMM' => get_month_name(date_obj.month),
    'MMMM' => get_month_name(date_obj.month, full: true)
  }
  
  # Apply custom token replacements
  token_replacements.each do |token, replacement|
    formatted = formatted.gsub(token, replacement)
  end
  
  # Apply standard strftime formatting for any remaining tokens
  begin
    date_obj.strftime(formatted)
  rescue
    formatted
  end
end

def get_day_name(day_index, full: false)
  days = full ? 
    ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'] :
    ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
  
  days[day_index] || 'Unknown'
end

def get_month_name(month_index, full: false)
  months = full ?
    ['', 'January', 'February', 'March', 'April', 'May', 'June',
     'July', 'August', 'September', 'October', 'November', 'December'] :
    ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
     'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  
  months[month_index] || 'Unknown'
end

def relative_date_format(date_input)
  date_obj = parse_date_input(date_input)
  now = Time.now
  
  diff_seconds = (now - date_obj).to_i
  
  case diff_seconds
  when 0..59
    "#{diff_seconds} seconds ago"
  when 60..3599
    minutes = diff_seconds / 60
    "#{minutes} minutes ago"
  when 3600..86399
    hours = diff_seconds / 3600
    "#{hours} hours ago"
  when 86400..2591999
    days = diff_seconds / 86400
    "#{days} days ago"
  else
    date_format(date_obj, "%B %d, %Y")
  end
end

def parse_date_input(date_input)
  case date_input
  when Time
    date_input
  when Date
    date_input.to_time
  when String
    parse_date_string(date_input)
  when Integer
    Time.at(date_input)
  else
    raise ArgumentError, "Unsupported date input type: #{date_input.class}"
  end
end