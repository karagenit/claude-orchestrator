def truncate_string(str, length, suffix = "...")
  return str if str.length <= length
  
  truncated_length = length - suffix.length
  return suffix if truncated_length <= 0
  
  str[0, truncated_length] + suffix
end