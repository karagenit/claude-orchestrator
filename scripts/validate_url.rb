def validate_url(url)
  return false if url.nil? || url.empty?
  
  return false unless url.match?(/^https?:\/\//)
  
  uri_pattern = /^https?:\/\/[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*(:([0-9]{1,5}))?([/?#].*)?$/
  
  url.match?(uri_pattern)
end