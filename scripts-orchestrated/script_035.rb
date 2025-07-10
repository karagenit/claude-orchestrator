def json_parse_safe(json_string, default_value = nil)
  return default_value if json_string.nil? || json_string.strip.empty?
  
  begin
    result = parse_json_value(json_string.strip)
    result
  rescue => e
    puts "JSON parsing error: #{e.message}" if $DEBUG
    default_value
  end
end

def parse_json_value(json_string)
  json_string = json_string.strip
  
  case json_string[0]
  when '{'
    parse_json_object(json_string)
  when '['
    parse_json_array(json_string)
  when '"'
    parse_json_string(json_string)
  when 't', 'f'
    parse_json_boolean(json_string)
  when 'n'
    parse_json_null(json_string)
  else
    parse_json_number(json_string)
  end
end

def parse_json_object(json_string)
  return {} if json_string == "{}"
  
  json_string = json_string[1...-1].strip
  result = {}
  
  while !json_string.empty?
    # Parse key
    key_match = json_string.match(/^"([^"]*)"/)
    raise "Invalid object key" unless key_match
    key = key_match[1]
    json_string = json_string[key_match[0].length..].strip
    
    # Expect colon
    raise "Expected ':' after object key" unless json_string.start_with?(':')
    json_string = json_string[1..].strip
    
    # Parse value
    value, remaining = parse_json_value_with_remaining(json_string)
    result[key] = value
    json_string = remaining.strip
    
    # Handle comma or end
    if json_string.start_with?(',')
      json_string = json_string[1..].strip
    elsif !json_string.empty?
      raise "Expected ',' or end of object"
    end
  end
  
  result
end

def parse_json_array(json_string)
  return [] if json_string == "[]"
  
  json_string = json_string[1...-1].strip
  result = []
  
  while !json_string.empty?
    value, remaining = parse_json_value_with_remaining(json_string)
    result << value
    json_string = remaining.strip
    
    if json_string.start_with?(',')
      json_string = json_string[1..].strip
    elsif !json_string.empty?
      raise "Expected ',' or end of array"
    end
  end
  
  result
end

def parse_json_value_with_remaining(json_string)
  case json_string[0]
  when '{'
    end_pos = find_matching_brace(json_string, '{', '}')
    value = parse_json_object(json_string[0..end_pos])
    [value, json_string[end_pos + 1..]]
  when '['
    end_pos = find_matching_brace(json_string, '[', ']')
    value = parse_json_array(json_string[0..end_pos])
    [value, json_string[end_pos + 1..]]
  when '"'
    end_pos = find_string_end(json_string)
    value = parse_json_string(json_string[0..end_pos])
    [value, json_string[end_pos + 1..]]
  else
    # Number, boolean, or null
    end_pos = json_string.index(/[,\]\}]/) || json_string.length
    value_str = json_string[0...end_pos].strip
    value = parse_json_primitive(value_str)
    [value, json_string[end_pos..]]
  end
end

def parse_json_string(json_string)
  json_string[1...-1].gsub(/\\(.)/) do |match|
    case $1
    when 'n' then "\n"
    when 't' then "\t"
    when 'r' then "\r"
    when 'b' then "\b"
    when 'f' then "\f"
    when '"' then '"'
    when '\\' then '\\'
    when '/' then '/'
    else $1
    end
  end
end

def parse_json_number(json_string)
  if json_string.include?('.') || json_string.downcase.include?('e')
    json_string.to_f
  else
    json_string.to_i
  end
end

def parse_json_boolean(json_string)
  json_string == 'true'
end

def parse_json_null(json_string)
  nil
end

def parse_json_primitive(value_str)
  case value_str
  when 'true', 'false'
    value_str == 'true'
  when 'null'
    nil
  else
    parse_json_number(value_str)
  end
end

def find_matching_brace(str, open_char, close_char)
  count = 0
  str.each_char.with_index do |char, i|
    if char == open_char
      count += 1
    elsif char == close_char
      count -= 1
      return i if count == 0
    end
  end
  raise "Unmatched #{open_char}"
end

def find_string_end(str)
  i = 1
  while i < str.length
    if str[i] == '"' && str[i-1] != '\\'
      return i
    end
    i += 1
  end
  raise "Unterminated string"
end