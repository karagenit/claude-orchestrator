require 'json'

def json_pretty_print(json_string)
  begin
    parsed = JSON.parse(json_string)
    JSON.pretty_generate(parsed)
  rescue JSON::ParserError
    nil
  end
end