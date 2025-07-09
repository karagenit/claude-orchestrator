def is_palindrome(str)
  cleaned = str.downcase.gsub(/[^a-z0-9]/, '')
  left = 0
  right = cleaned.length - 1
  
  while left < right
    return false if cleaned[left] != cleaned[right]
    left += 1
    right -= 1
  end
  
  true
end