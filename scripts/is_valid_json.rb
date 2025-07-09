require 'json'

def is_valid_json(json_string)
  return false if json_string.nil? || json_string.empty?
  
  begin
    JSON.parse(json_string)
    true
  rescue JSON::ParserError
    false
  end
end