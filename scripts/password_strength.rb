def password_strength(password)
  return 0 if password.nil? || password.empty?
  
  score = 0
  
  score += 1 if password.length >= 8
  score += 1 if password.length >= 12
  score += 1 if password.match?(/[a-z]/)
  score += 1 if password.match?(/[A-Z]/)
  score += 1 if password.match?(/[0-9]/)
  score += 1 if password.match?(/[^a-zA-Z0-9]/)
  
  case score
  when 0..2
    "weak"
  when 3..4
    "medium"
  when 5..6
    "strong"
  else
    "very strong"
  end
end