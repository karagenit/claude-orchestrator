def nth_root(number, n)
  return nil if n == 0
  return number if n == 1
  return nil if number < 0 && n.even?
  
  if number < 0
    return -nth_root(-number, n)
  end
  
  number ** (1.0 / n)
end