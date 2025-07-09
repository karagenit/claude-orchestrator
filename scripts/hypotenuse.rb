def hypotenuse(a, b)
  return 0 if a <= 0 || b <= 0
  
  Math.sqrt(a ** 2 + b ** 2)
end