def time_diff(start_time, end_time = nil, options = {})
  end_time ||= Time.now
  
  start_obj = parse_time_input(start_time)
  end_obj = parse_time_input(end_time)
  
  diff_seconds = (end_obj - start_obj).to_f
  
  format = options[:format] || :hash
  precision = options[:precision] || 2
  
  case format
  when :seconds
    diff_seconds.round(precision)
  when :human
    human_readable_time_diff(diff_seconds)
  when :detailed
    detailed_time_diff(diff_seconds)
  else
    time_diff_hash(diff_seconds, precision)
  end
end

def parse_time_input(time_input)
  case time_input
  when Time
    time_input
  when Date
    time_input.to_time
  when String
    parse_time_string(time_input)
  when Integer, Float
    Time.at(time_input)
  else
    raise ArgumentError, "Unsupported time input type: #{time_input.class}"
  end
end

def parse_time_string(time_string)
  time_string = time_string.strip
  
  # Try common time formats
  formats = [
    "%Y-%m-%d %H:%M:%S",     # 2023-12-25 15:30:45
    "%Y-%m-%d %H:%M",        # 2023-12-25 15:30
    "%Y-%m-%d",              # 2023-12-25
    "%m/%d/%Y %H:%M:%S",     # 12/25/2023 15:30:45
    "%m/%d/%Y %H:%M",        # 12/25/2023 15:30
    "%m/%d/%Y",              # 12/25/2023
    "%Y-%m-%dT%H:%M:%S",     # ISO 8601 format
    "%Y-%m-%dT%H:%M:%SZ",    # ISO 8601 with Z
    "%Y-%m-%dT%H:%M:%S%z",   # ISO 8601 with timezone
  ]
  
  formats.each do |format|
    begin
      return Time.strptime(time_string, format)
    rescue ArgumentError
      next
    end
  end
  
  # If no format matches, try built-in parsing
  Time.parse(time_string)
end

def time_diff_hash(diff_seconds, precision)
  abs_diff = diff_seconds.abs
  
  years = (abs_diff / (365.25 * 24 * 3600)).floor
  remaining = abs_diff % (365.25 * 24 * 3600)
  
  days = (remaining / (24 * 3600)).floor
  remaining = remaining % (24 * 3600)
  
  hours = (remaining / 3600).floor
  remaining = remaining % 3600
  
  minutes = (remaining / 60).floor
  seconds = (remaining % 60).round(precision)
  
  {
    years: years,
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
    total_seconds: diff_seconds.round(precision),
    negative: diff_seconds < 0
  }
end

def human_readable_time_diff(diff_seconds)
  abs_diff = diff_seconds.abs
  negative = diff_seconds < 0
  
  case abs_diff
  when 0..59
    unit = "second"
    value = abs_diff.round
  when 60..3599
    unit = "minute"
    value = (abs_diff / 60).round
  when 3600..86399
    unit = "hour"
    value = (abs_diff / 3600).round
  when 86400..2591999
    unit = "day"
    value = (abs_diff / 86400).round
  when 2592000..31535999
    unit = "month"
    value = (abs_diff / 2592000).round
  else
    unit = "year"
    value = (abs_diff / 31536000).round
  end
  
  plural = value != 1 ? "s" : ""
  direction = negative ? " ago" : " from now"
  
  "#{value} #{unit}#{plural}#{direction}"
end

def detailed_time_diff(diff_seconds)
  components = time_diff_hash(diff_seconds, 0)
  parts = []
  
  parts << "#{components[:years]} year#{'s' if components[:years] != 1}" if components[:years] > 0
  parts << "#{components[:days]} day#{'s' if components[:days] != 1}" if components[:days] > 0
  parts << "#{components[:hours]} hour#{'s' if components[:hours] != 1}" if components[:hours] > 0
  parts << "#{components[:minutes]} minute#{'s' if components[:minutes] != 1}" if components[:minutes] > 0
  parts << "#{components[:seconds].to_i} second#{'s' if components[:seconds].to_i != 1}" if components[:seconds] > 0
  
  result = parts.empty? ? "0 seconds" : parts.join(", ")
  result += components[:negative] ? " ago" : " from now"
  
  result
end

def time_diff_in_words(start_time, end_time = nil)
  human_readable_time_diff(time_diff(start_time, end_time, format: :seconds))
end

def time_ago(time_input)
  time_diff(time_input, Time.now, format: :human)
end

def time_until(time_input)
  time_diff(Time.now, time_input, format: :human)
end