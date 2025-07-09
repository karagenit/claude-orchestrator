def validate_email(email)
  return false if email.nil? || email.empty?
  
  parts = email.split('@')
  return false if parts.length != 2
  
  local, domain = parts
  return false if local.empty? || domain.empty?
  
  return false if local.length > 64 || domain.length > 253
  return false if local.start_with?('.') || local.end_with?('.')
  return false if local.include?('..')
  
  domain_parts = domain.split('.')
  return false if domain_parts.length < 2
  return false if domain_parts.any?(&:empty?)
  
  local.match?(/^[a-zA-Z0-9._-]+$/) && domain.match?(/^[a-zA-Z0-9.-]+$/)
end