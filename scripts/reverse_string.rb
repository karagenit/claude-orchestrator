def reverse_string(str)
  left = 0
  right = str.length - 1
  chars = str.chars
  
  while left < right
    chars[left], chars[right] = chars[right], chars[left]
    left += 1
    right -= 1
  end
  
  chars.join
end