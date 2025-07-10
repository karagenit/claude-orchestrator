def validate_email(email)
  return false if email.nil? || email.strip.empty?
  
  email = email.strip.downcase
  
  local_part_pattern = /\A[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+\/=?^_`{|}~-]+)*\z/
  domain_part_pattern = /\A[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/
  
  at_count = email.count('@')
  return false unless at_count == 1
  
  local_part, domain_part = email.split('@')
  
  return false if local_part.empty? || domain_part.empty?
  return false if local_part.length > 64 || domain_part.length > 253
  
  return false unless local_part_pattern.match?(local_part)
  return false unless domain_part_pattern.match?(domain_part)
  
  return false if local_part.start_with?('.') || local_part.end_with?('.')
  return false if local_part.include?('..')
  
  return false if domain_part.start_with?('.') || domain_part.end_with?('.')
  return false if domain_part.include?('..')
  
  domain_labels = domain_part.split('.')
  return false if domain_labels.any? { |label| label.empty? || label.length > 63 }
  
  return false unless domain_labels.last.match?(/\A[a-zA-Z]{2,}\z/)
  
  return false if domain_part.start_with?('-') || domain_part.end_with?('-')
  
  true
end

if __FILE__ == $0
  test_emails = [
    "test@example.com",
    "user.name@domain.co.uk",
    "invalid.email",
    "@domain.com",
    "user@",
    "user@domain",
    "user..name@domain.com",
    "user@domain..com",
    "valid123@test-domain.org"
  ]
  
  test_emails.each do |email|
    result = validate_email(email)
    puts "#{email}: #{result ? 'VALID' : 'INVALID'}"
  end
end